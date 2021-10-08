defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    number
    |> Integer.to_string()
    |> String.split("", trim: true)
    |> Enum.map(&map_string_int_to_int/1)
    |> armstrong_computer()
    |> Kernel.==(number)
  end

  defp map_string_int_to_int(string_int) do
    string_int
    |> Integer.parse()
    |> elem(0)
  end

  defp armstrong_computer(list) do
    pow = length(list)

    Enum.reduce(list, 0, fn num, acc -> acc + Integer.pow(num, pow) end)
  end
end
