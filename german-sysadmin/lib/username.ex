defmodule Username do
  @lowercase_charpoints 97..122
  @underscore_charpoint 95

  def sanitize(username) do
    # ä becomes ae
    # ö becomes oe
    # ü becomes ue
    # ß becomes ss
    username
    |> Enum.flat_map(&substitute_german_chars/1)
    |> Enum.filter(&allow_character/1)
  end

  defp substitute_german_chars(char) do
    case char do
      228 -> 'ae'
      246 -> 'oe'
      252 -> 'ue'
      223 -> 'ss'
      _ -> [char]
    end
  end

  defp allow_character(char), do: char in @lowercase_charpoints or char == @underscore_charpoint
end
