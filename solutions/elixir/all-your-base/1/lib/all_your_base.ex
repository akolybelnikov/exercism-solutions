defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    cond do
      input_base < 2 -> {:error, "input base must be >= 2"}
      output_base < 2 -> {:error, "output base must be >= 2"}
      true -> convert_digits(digits, input_base, output_base)
    end
  end

  defp convert_digits(digits, input_base, output_base) do
    with {:ok, decimal} <- to_decimal(digits, input_base),
         {:ok, converted} <- from_decimal(decimal, output_base) do
      {:ok, converted}
    else
      {:error, message} -> {:error, message}
    end
  end

  defp to_decimal(digits, input_base) do
    digits
    |> Enum.with_index()
    |> Enum.reduce_while({:ok, 0}, fn {digit, index}, {:ok, acc} ->
      cond do
        digit < 0 or digit >= input_base ->
          {:halt, {:error, "all digits must be >= 0 and < input base"}}

        true ->
          {:cont, {:ok, acc + digit * Integer.pow(input_base, length(digits) - index - 1)}}
      end
    end)
  end

  defp from_decimal(0, _output_base), do: {:ok, [0]}

  defp from_decimal(decimal, output_base) do
    do_from_decimal(decimal, output_base, [])
  end

  defp do_from_decimal(0, _output_base, digits), do: {:ok, digits}

  defp do_from_decimal(decimal, output_base, digits) do
    do_from_decimal(div(decimal, output_base), output_base, [rem(decimal, output_base) | digits])
  end
end
