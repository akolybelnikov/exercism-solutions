defmodule ResistorColorTrio do
  defp code(:black), do: 0
  defp code(:brown), do: 1
  defp code(:red), do: 2
  defp code(:orange), do: 3
  defp code(:yellow), do: 4
  defp code(:green), do: 5
  defp code(:blue), do: 6
  defp code(:violet), do: 7
  defp code(:grey), do: 8
  defp code(:white), do: 9

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """

  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    value_1 = code(Enum.at(colors, 0))
    value_2 = code(Enum.at(colors, 1))
    multiplier = code(Enum.at(colors, 2))
    value = (value_1 * 10 + value_2) * Integer.pow(10, multiplier)

    cond do
      value >= 1_000_000_000 -> {div(value, 1_000_000_000), :gigaohms}
      value >= 1_000_000 -> {div(value, 1_000_000), :megaohms}
      value >= 1_000 -> {div(value, 1_000), :kiloohms}
      true -> {value, :ohms}
    end
  end
end
