defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
      _ -> :none
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
      _ -> :none
    end
  end

  def encode(dna) do
    do_encode(dna, <<>>)
  end

  defp do_encode([], acid), do: acid

  defp do_encode([head | tail], acid) do
    n = encode_nucleotide(head)
    do_encode(tail, <<acid::bitstring, n::4>>)
  end

  def decode(dna) do
     acc = do_decode(dna, [])
    do_reverse(acc, [])
  end

  defp do_decode(<<>>, acc), do: acc

  defp do_decode(<<n::4, rest::bitstring>>, acc) do
    d = decode_nucleotide(n)
    do_decode(rest, [d | acc])
  end

  defp do_reverse([], acc), do: acc
  defp do_reverse([h | t], acc), do: do_reverse(t, [h | acc])
end
