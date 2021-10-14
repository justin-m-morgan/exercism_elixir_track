defmodule VariableLengthQuantity do
  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode([hd])  do
    do_encode(<<hd>>,hd)
  end


  def reduce_to_list(number, acc) when number <= 128, do: [number | acc]
  def reduce_to_list(number, acc) do
    reduce_to_list(number - 128, [128 | acc])
  end


  defp do_encode([], num), do: num
  defp do_encode([hd | tail], num) do
    do_encode(tail, <<hd, num>>)
  end



  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(bytes) do
  end
end
