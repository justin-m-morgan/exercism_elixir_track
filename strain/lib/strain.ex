defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun), do: do_keep(list, fun)

  defp do_keep(list, fun, acc \\ [])
  defp do_keep([], _fun, acc), do: Enum.reverse(acc)

  defp do_keep([hd | tail], fun, acc) do
    case fun.(hd) do
      true -> do_keep(tail, fun, [hd | acc])
      false -> do_keep(tail, fun, acc)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    fun = &(not fun.(&1))
    do_keep(list, fun)
  end
end
