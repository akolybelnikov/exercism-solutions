defmodule SecretHandshake do
  import Bitwise

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
    code = trunc(code) &&& 0b1_1111

    ops = [
      {0b01000, "jump"},
      {0b00100, "close your eyes"},
      {0b00010, "double blink"},
      {0b00001, "wink"},
      {0b10000, :reverse}
    ]

    ops
    |> addOp(code, [])
  end

  defp addOp([], _code, acc), do: acc

  defp addOp([{mask, op} | tail], code, acc) do
    acc =
      if (code &&& mask) == mask do
        case op do
          :reverse -> reverse(acc, [])
          _ -> [op | acc]
        end
      else
        acc
      end

    addOp(tail, code, acc)
  end

  defp reverse([], acc), do: acc

  defp reverse([head | tail], acc) do
    reverse(tail, [head | acc])
  end
end
