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
    for(c <- dna, do: encode_nucleotide(c))
    |> then(&for code <- &1, into: <<>>, do: <<code::4>>)
  end

  def decode(dna) do
    for <<n::4 <- dna>>, into: ~c"", do: decode_nucleotide(n)
  end
end
