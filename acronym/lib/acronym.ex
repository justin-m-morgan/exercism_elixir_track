defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.replace("_", "")
    |> String.replace("-", " ")
    |> String.split(" ", trim: true)
    |> Enum.map(&word_to_upper_first_letter/1)
    |> Enum.join()

  end

  defp word_to_upper_first_letter(word) do
    word
    |> String.at(0)
    |> String.upcase()
  end

end
