defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2),
    do: {:error, "strands must be of equal length"}
  def hamming_distance(strand1, strand2) do
    distance =
    strand1
    |> Enum.zip(strand2)
    |> Enum.reduce(0, &count_differences/2)
    {:ok, distance}
  end

  defp count_differences({c1, c2}, acc) when c1 != c2, do: acc + 1
  defp count_differences(_chars, acc), do: acc
end
