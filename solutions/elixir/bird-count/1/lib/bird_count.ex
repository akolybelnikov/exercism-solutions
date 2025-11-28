defmodule BirdCount do
  def today([]), do: nil

  def today([head | _tail]), do: head

  def increment_day_count([]), do: [1]

  def increment_day_count([head | tail]), do: [head + 1 | tail]

  def has_day_without_birds?(list), do: 0 in list

  def total(list), do: Enum.sum(list)

  def busy_days([]), do: 0

  def busy_days(list), do: Enum.reduce(list, 0, fn x, acc -> if x >= 5, do: acc + 1, else: acc end)
end
