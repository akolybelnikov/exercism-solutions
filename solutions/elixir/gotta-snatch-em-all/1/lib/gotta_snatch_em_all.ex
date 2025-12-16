defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    {MapSet.member?(collection, card), MapSet.put(collection, card)}
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    new_col =
      collection
      |> MapSet.delete(your_card)
      |> MapSet.put(their_card)

    if MapSet.member?(collection, your_card) && !MapSet.member?(collection, their_card) do
      {true, new_col}
    else
      {false, new_col}
    end
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    MapSet.new(cards)
    |> MapSet.to_list()
    |> Enum.sort()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    MapSet.difference(your_collection, their_collection) |> MapSet.size()
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards([]), do: []

  def boring_cards([first | rest]) do
    do_boring_cards(first, rest)
    |> MapSet.to_list()
    |> Enum.sort()
  end

  @spec do_boring_cards(collection(), [collection()]) :: collection()
  defp do_boring_cards(acc, []), do: acc

  defp do_boring_cards(acc, [head | rest]) do
    MapSet.intersection(acc, head) |> do_boring_cards(rest)
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards([]), do: 0

  def total_cards([first | rest]) do
    do_total_cards(first, rest) |> MapSet.size()
  end

  defp do_total_cards(acc, []), do: acc

  defp do_total_cards(acc, [head | rest]) do
    MapSet.union(acc, head) |> do_total_cards(rest)
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    MapSet.split_with(collection, fn card -> String.starts_with?(card, "Shiny") end)
    |> then(fn split ->
      t = elem(split, 0) |> Enum.sort()
      f = elem(split, 1) |> Enum.sort()
      {t, f}
    end)
  end
end
