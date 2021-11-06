defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    files
    |> Enum.map(fn file -> Task.async(fn -> grep_one(pattern, flags, file) end) end)
    |> Task.await_many()
    |> Enum.map(fn task -> Enum.filter(task, fn {_filename, results} -> results end) end)
    |> process_final_results()
  end

  defp process_final_results([]), do: ""
  defp process_final_results([results]) when is_binary(results), do: results
  defp process_final_results(results) do
    multiple_results? = length(results) > 1

    results
    |> List.flatten()
    |> Enum.map(fn results -> process_filename_only(results, multiple_results?) end)
    |> Enum.join("")
  end

  defp process_filename_only(results, multiple_results?)
  defp process_filename_only({_filename, result}, false), do: result
  defp process_filename_only({filename, result}, _) when filename <> "\n" == result, do: result
  defp process_filename_only({filename, result}, _), do: "#{filename}:#{result}"


  def grep_one(pattern, flags, file) do
    opts = parse_flags(flags)

    file
    |> File.stream!(encoding: :utf8)
    |> Stream.with_index()
    |> Stream.filter(fn line_tuple -> filter_with_opts(line_tuple, pattern, opts) end)
    |> Stream.map(fn line_tuple -> maybe_process_line_number(line_tuple, opts[:line_number]) end)
    |> Enum.to_list()
    |> maybe_print_filename(file, opts[:file_name_only])
    |> pair_with_filename(file)
  end

  defp maybe_make_case_insensitive(line, pattern, true), do: {String.downcase(line), String.downcase(pattern)}
  defp maybe_make_case_insensitive(line, pattern, _), do: {line, pattern}

  defp maybe_match_whole_line(line, pattern, match_whole_line)
  defp maybe_match_whole_line(line, pattern, true), do: String.trim_trailing(line) == pattern
  defp maybe_match_whole_line(line, pattern, _), do: String.contains?(line, pattern)

  defp maybe_invert_program(result, true), do: not result
  defp maybe_invert_program(result, _), do: result

  defp maybe_process_line_number({line, line_number}, true), do: "#{line_number + 1}:#{line}"
  defp maybe_process_line_number({line, _line_number}, _), do: line

  defp maybe_print_filename(results, file, flag)
  defp maybe_print_filename([], _file, _), do: [false]
  defp maybe_print_filename(_results, file, true), do: [file <> "\n"]
  defp maybe_print_filename(results, _file, _), do: results

  defp filter_with_opts({line, _line_number}, pattern, opts) do
    {line, pattern} = maybe_make_case_insensitive(line, pattern, opts[:case_insensitive])

    line
    |> maybe_match_whole_line(pattern, opts[:match_line])
    |> maybe_invert_program(opts[:invert_program])
  end

  defp pair_with_filename(results, file), do: Enum.map(results, fn line -> {file, line} end)

  def parse_flags(flags) do
    OptionParser.parse(
      flags,
      aliases: [
        n: :line_number,
        l: :file_name_only,
        i: :case_insensitive,
        v: :invert_program,
        x: :match_line
      ],
      strict: [
        line_number: :boolean,
        file_name_only: :boolean,
        case_insensitive: :boolean,
        invert_program: :boolean,
        match_line: :boolean
      ]
    ) |> elem(0)
  end
end
