defmodule Allergies do
  @candidates ~w/cats pollen chocolate tomatoes strawberries shellfish peanuts eggs/

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(0), do: []
  def list(flags) do
    do_list(<<flags::size(8)>>)
  end

  def do_list(flags, accumulator \\ [], candidates \\ @candidates)
  def do_list(_flags, accumulator, []), do: accumulator
  def do_list(<<hd::size(1), next::bitstring>>, accumulator, [check | rest]) do
    cond do
      hd == 1 -> do_list( next, [check | accumulator], rest)
      hd == 0 -> do_list( next, accumulator, rest)
    end
  end


  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    item in list(flags)
  end
end
