defmodule DNA do
  def encode_nucleotide(?\s), do: 0b0000
  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000

  def decode_nucleotide(0b0000), do: ?\s
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T

  def encode(dna, code \\ <<>>)
  def encode([], code), do: code

  def encode([hd | tail], code) do
    encoded_nuc = <<encode_nucleotide(hd)::4>>
    encode(tail, <<code::bitstring, encoded_nuc::bitstring>>)
  end

  def decode(dna, decoded \\ [])

  def decode("", decoded) do
    decoded
    |> Enum.map(&decode_nucleotide/1)
    |> Enum.reverse()
  end

  def decode(<<hd::size(4), rest::bitstring>>, decoded) do
    decode(rest, [hd | decoded])
  end
end
