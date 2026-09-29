defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    valid_size = size > 0 && size <= String.length(number_string)

    case {number_string, size} do
      {number_string, size} when valid_size ->
        String.graphemes(number_string)
        |> Enum.map(&String.to_integer/1)
        |> Enum.chunk_every(size, 1, :discard)
        |> Enum.map(&product/1)
        |> Enum.max()

      _ ->
        raise ArgumentError, "invalid input"
    end
  end

  defp product(chunk), do: Enum.reduce(chunk, 1, &*/2)
end
