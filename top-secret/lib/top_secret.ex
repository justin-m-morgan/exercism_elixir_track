defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(ast, acc \\ [])
  def decode_secret_message_part({match, _, _} = ast, acc)
    when match in [:when, :def, :defp], do: do_decode_part(ast, acc)
  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    string
    |> to_ast()
    |> extract_multiple()
    |> Enum.map(fn module_or_funs ->
      module_or_funs
      |> extract_multiple()
      |> Enum.map(&extract_functions_from_module/1)
      |> maybe_extract_block()
      |> Enum.map(&decode_secret_message_part/1)
      |> Enum.map(&elem(&1, 1))
      |> List.flatten()
      |> Enum.join()
    end)
    |> Enum.join()
  end

  defp do_decode_part(ast, acc) do
    {
      ast,
      ast
      |> extract_function_name_args()
      |> append_truncated_name(acc)
    }
  end

  defp extract_function_name_args({_, _, [{:when, _, [{function_name, _, args} | _]} | _]}),
    do: {function_name, args}

  defp extract_function_name_args({_, _, [{function_name, _, args} | _]}),
    do: {function_name, args}

  defp append_truncated_name({function_name, args}, accumulator),
    do: [truncate_atom_to_string(function_name, args) | accumulator]

  defp truncate_atom_to_string(_atom, args) when not is_list(args), do: ""
  defp truncate_atom_to_string(_atom, args) when length(args) == 0, do: ""
  defp truncate_atom_to_string(atom, args) do
    atom
    |> Atom.to_string()
    |> String.slice(Range.new(0, length(args) - 1))
  end

  defp maybe_extract_block([{:__block__, _, _}] = ast) do
    ast
    |> Enum.map(&extract_multiple/1)
    |> List.flatten()
  end

  defp maybe_extract_block(ast), do: ast

  defp extract_multiple({:__block__, _, units}), do: units
  defp extract_multiple({:def, _, _} = ast), do: [ast]
  defp extract_multiple({:defp, _, _} = ast), do: [ast]
  defp extract_multiple({:defmodule, _, _} = ast), do: [ast] |> List.flatten()

  defp extract_functions_from_module({:defmodule, _, [{_, _, _}, [fns]]}) do
    {:do, fun} = fns
    fun
  end
  defp extract_functions_from_module(ast), do: ast
end
