defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code = <<code::size(5)>>

    []
    |> maybe_append(wink(code), "wink")
    |> maybe_append(double_blink(code), "double blink")
    |> maybe_append(close_eyes(code), "close your eyes")
    |> maybe_append(jump(code), "jump")
    |> maybe_reverse(code)
  end

  defp maybe_append(list, predicate, value), do: if(predicate, do: [value | list], else: list)
  defp wink(<<_hd::4, wink::1>>), do: if(wink == 1, do: true)
  defp double_blink(<<_hd::3, db::1, _tl::1>>), do: if(db == 1, do: true)
  defp close_eyes(<<_hd::2, close::1, _tl::2>>), do: if(close == 1, do: true)
  defp jump(<<_hd::1, jump::1, _tl::3>>), do: if(jump == 1, do: true)

  defp maybe_reverse(list, <<reverse::1, _tl::4>>) do
    if reverse == 0, do: Enum.reverse(list), else: list
  end
end
