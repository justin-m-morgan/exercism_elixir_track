defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    with :ok <- valid_output_base(output_base),
         :ok <- valid_input_base(input_base),
         :ok <- inputs_valid(digits, input_base) do
      new_base =
        digits
        |> handle_leading_zeros()
        |> convert_to_decimal(input_base)
        |> convert_from_decimal(output_base)

      {:ok, new_base}
    else
      err -> err
    end
  end

  def handle_leading_zeros(list) do
    zeroed = Enum.drop_while(list, fn num -> num == 0 end)

    case length(zeroed) do
      0 -> [0]
      _ -> zeroed
    end
  end

  def valid_input_base(input_base) when input_base < 2,
    do: {:error, "input base must be >= 2"}

  def valid_input_base(_input_base), do: :ok

  def valid_output_base(output_base) when output_base < 2,
    do: {:error, "output base must be >= 2"}

  def valid_output_base(_output_base), do: :ok

  defp inputs_valid(list, input_base) do
    case Enum.all?(list, &valid_number?(&1, input_base) ) do
      true -> :ok
      false -> {:error, "all digits must be >= 0 and < input base"}
    end
  end
  defp valid_number?(num, input_base) do
    num >= 0 and num < input_base
  end

  def convert_to_decimal(list, base) do
    list_length = length(list)

    list
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {val, exponent}, acc -> acc + val * Integer.pow(base, exponent) end)
  end

  def convert_from_decimal(decimal, base, accumulator \\ [])

  def convert_from_decimal(decimal, _base, accumulator)
      when decimal == 0 and length(accumulator) == 0,
      do: [0]

  def convert_from_decimal(decimal, _base, accumulator) when decimal == 0, do: accumulator

  def convert_from_decimal(decimal, base, accumulator) do
    remainder = Integer.mod(decimal, base)
    accumulator = [remainder | accumulator]

    decimal
    |> div(base)
    |> convert_from_decimal(base, accumulator)
  end
end
