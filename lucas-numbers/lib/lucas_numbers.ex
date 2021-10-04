defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """

  def generate(1), do: [2]
  def generate(2), do: [2, 1]

  def generate(count) when is_integer(count) and count > 1 do
    [2 | lucas(count)]
  end

  def generate(_n),
    do: raise(ArgumentError, message: "count must be specified as an integer >= 1")

  defp lucas(n) do
    Stream.iterate({2, 1}, fn {a, b} -> {b, a + b} end)
    |> Stream.map(fn {_a, b} -> b end)
    |> Enum.take(n - 1)
  end
end
