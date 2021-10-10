defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    input
    |> preprocess_input()
    |> categorize_input()
    |> response()
  end

  defp preprocess_input(input) do
    input
    |> String.trim()
  end

  defp categorize_input(input) do
    cond do
      silence?(input) -> :empty
      yell?(input) and question?(input) -> :yell_question
      yell?(input) -> :yell
      question?(input) -> :question
      true -> :something_else
    end
  end

  defp response(:question), do: "Sure."
  defp response(:yell), do: "Whoa, chill out!"
  defp response(:yell_question), do: "Calm down, I know what I'm doing!"
  defp response(:empty), do: "Fine. Be that way!"
  defp response(_), do: "Whatever."

  defp yell?(input) do
    charlist = String.to_charlist(input)

    Enum.all?(charlist, fn char -> char not in ?a..?z end) and
    Enum.any?(charlist, fn char -> char >= ?A end)

  end
  defp question?(input), do: String.last(input) == "?"
  defp silence?(input), do: String.length(input) == 0

end
