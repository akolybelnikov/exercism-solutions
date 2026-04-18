defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) do
    with true <- is_integer(input), true <- input > 0 do
      do_calc(input, 0)
    else
      false -> raise FunctionClauseError
    end
  end

  defp do_calc(input, count) do
    cond do
      input == 1 -> count
      rem(input, 2) == 0 -> do_calc(div(input, 2), count + 1)
      true -> do_calc(input * 3 + 1, count + 1)
    end
  end
end
