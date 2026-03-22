defmodule VariableLengthQuantity do
  import Bitwise

  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode(integers) do
    integers
    |> Enum.map(&do_encode/1)
    |> :erlang.list_to_binary()
  end

  defp do_encode(0), do: <<0>>

  defp do_encode(n) do
    do_encode(n, <<>>)
  end

  defp do_encode(0, acc), do: acc

  defp do_encode(n, acc) do
    lower_7_bits = n &&& 0x7F
    rest = n >>> 7

    # Set continuation bit for all bytes except the last (rightmost)
    byte = if acc == <<>>, do: lower_7_bits, else: 0x80 ||| lower_7_bits

    do_encode(rest, <<byte>> <> acc)
  end

  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(bytes) do
    do_decode(bytes, <<>>, [])
  end

  defp do_decode(<<>>, <<>>, acc), do: {:ok, Enum.reverse(acc)}

  defp do_decode(<<byte::8, rest::binary>>, _cur, _acc)
       when band(byte, 0x80) != 0 and rest == <<>>, do: {:error, "incomplete sequence"}

  defp do_decode(<<1::1, bits::7, rest::binary>>, cur, acc) do
    do_decode(rest, <<cur::bitstring, bits::7>>, acc)
  end

  defp do_decode(<<0::1, bits::7, rest::binary>>, cur, acc) do
    final = <<cur::bitstring, bits::7>>
    <<value::size(bit_size(final))>> = final
    do_decode(rest, <<>>, [value | acc])
  end
end
