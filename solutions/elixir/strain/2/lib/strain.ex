defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    keep(list, fun, [])
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    keep(list, fn x -> not fun.(x) end, [])
  end

  defp keep([], _fun, acc), do: reverse(acc, [])

  defp keep([h | t], fun, acc) do
    if fun.(h) do
      keep(t, fun, [h | acc])
    else
      keep(t, fun, acc)
    end
  end

  defp reverse([], acc), do: acc
  defp reverse([h | t], acc), do: reverse(t, [h | acc])
end
