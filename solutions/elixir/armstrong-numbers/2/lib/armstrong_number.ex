defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    to_digits(number, []) |> armstrong_number?(number)
  end

  defp to_digits(number, digits) do
    cond do
      number < 10 -> [number | digits]
      true -> to_digits(div(number, 10), [rem(number, 10) | digits])
    end
  end

  defp armstrong_number?(digits, number) do
    number == digits |> Enum.reduce(0, fn d, acc -> acc + Integer.pow(d, length(digits)) end)
  end
end
