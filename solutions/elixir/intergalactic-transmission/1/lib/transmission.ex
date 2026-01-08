defmodule Transmission do
  @doc """
  Return the transmission sequence for a message.
  """
  @spec get_transmit_sequence(binary()) :: binary()
  def get_transmit_sequence(message) do
    encode(message, <<>>, <<>>)
  end

  defp encode(<<>>, <<>>, acc), do: acc

  defp encode(data, carryover, acc) when bit_size(carryover) >= 8 do
    encode(carryover <> data, <<>>, acc)
  end

  defp encode(<<>>, carryover, acc) do
    parity_bit = process_bits(carryover, 0)
    padding = <<0::size(7 - bit_size(carryover))>>
    acc <> <<carryover::bitstring, padding::bitstring, parity_bit::size(1)>>
  end

  defp encode(<<byte::binary-size(1), rest::binary>>, carryover, acc) do
    <<bits::bitstring-size(7 - bit_size(carryover)), new_carryover::bitstring>> = byte
    chunk = <<carryover::bitstring, bits::bitstring>>
    parity_bit = process_bits(chunk, 0)

    encode(
      rest,
      new_carryover,
      acc <> <<chunk::bitstring, parity_bit::size(1)>>
    )
  end

  defp process_bits(<<>>, acc) do
    if rem(acc, 2) == 0, do: 0, else: 1
  end

  defp process_bits(<<bit::size(1), rest::bitstring>>, acc) do
    if bit == 1 do
      process_bits(rest, acc + 1)
    else
      process_bits(rest, acc)
    end
  end

  @doc """
  Return the message decoded from the received transmission.
  """
  @spec decode_message(binary()) :: {:ok, binary()} | {:error, String.t()}
  def decode_message(received_data) do
    decode(received_data, <<>>)
  end

  defp decode(<<>>, bit_acc) do
    {:ok, assemble_bytes(bit_acc)}
  end

  defp decode(<<cur::binary-size(1), rest::binary>>, bit_acc) do
    <<payload::bitstring-size(7), parity_bit::size(1)>> = cur

    if parity_bit != process_bits(payload, 0) do
      {:error, "wrong parity"}
    else
      decode(rest, <<bit_acc::bitstring, payload::bitstring>>)
    end
  end

  defp assemble_bytes(bit_acc, acc \\ <<>>)

  defp assemble_bytes(<<byte::size(8), rest::bitstring>>, acc) do
    assemble_bytes(rest, acc <> <<byte>>)
  end

  defp assemble_bytes(_, acc), do: acc
end
