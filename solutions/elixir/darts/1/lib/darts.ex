defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    s = x * x + y * y
    cond do
      s <= 1 -> 10
      s <= 25 -> 5
      s <= 100 -> 1
      true -> 0
    end
  end
end
