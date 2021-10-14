defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count >= 1 do
    do_nth(count - 1, 2, [2])
    |> List.first()
  end

  # Simple recursion with Trial Division strategy
  defp do_nth(count, candidate, accumulator)
  defp do_nth(0, _, accumulator ), do: accumulator
  defp do_nth(count, candidate, accumulator ) do
      case prime?(candidate, accumulator) do
        true -> do_nth(count - 1, candidate + 1, [candidate | accumulator])
        false -> do_nth(count, candidate + 1, accumulator)
      end
  end

  def prime?(candidate, lower_primes \\ []) do
    not Enum.any?(lower_primes, fn prime -> Integer.mod(candidate, prime) == 0 end)
  end

end
