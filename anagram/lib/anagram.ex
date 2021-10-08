defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.filter(fn candidate -> is_annagram(base, candidate) end)
  end

  @spec match(String.t(), String.t()) :: boolean()
  def is_annagram(base, candidate) do
    base = preprocess(base)
    candidate = preprocess(candidate)
    (base != candidate) and (Enum.sort(base) == Enum.sort(candidate))
  end

  defp preprocess(word) do
    word
    |> String.downcase()
    |> String.split("")
  end

end
