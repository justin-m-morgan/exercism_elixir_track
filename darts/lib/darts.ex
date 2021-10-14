defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position :: position) :: integer
  def score({x, y}) do
    {x, y}
    |> radius()
    |> reward()
  end

  def radius({x, y}) do
    (Float.pow(x * 1.0, 2) + Float.pow(y * 1.0, 2))
    |> Float.pow(0.5)
  end

  def reward(radius) when radius <= 1, do: 10
  def reward(radius) when radius <= 5, do: 5
  def reward(radius) when radius <= 10, do: 1
  def reward(_radius), do: 0
end
