defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _key), do: :not_found
  def search(numbers, key) do
    high_index = tuple_size(numbers) - 1
    do_search(numbers, key, 0, high_index)
  end

  def do_search(numbers, key, low_index, high_index) do

    mid_index = (high_index - low_index) |> div(2) |> Kernel.+(low_index)
    mid_value = elem(numbers, mid_index)

    cond do
      mid_value == key -> {:ok, mid_index}
      low_index == high_index -> :not_found
      mid_value > key -> do_search(numbers, key, low_index, mid_index)
      mid_value < key -> do_search(numbers, key, mid_index + 1, high_index)
    end
  end
end
