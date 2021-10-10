defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when is_integer(input) and input > 0 do
    do_calc(input)
  end

  def do_calc(input, iteration_count \\ 0)
  def do_calc(1, iteration_count), do: iteration_count
  def do_calc(input, iteration_count) do
    input
    |> operation()
    |> do_calc(iteration_count + 1)
  end

  defp operation(input) do
    case Integer.mod(input, 2) do
      0 -> div(input, 2)
      _ -> (input * 3) + 1
    end
  end
end
