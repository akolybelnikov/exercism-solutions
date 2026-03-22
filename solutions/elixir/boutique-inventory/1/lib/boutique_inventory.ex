defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    inventory |> Enum.sort_by(& &1.price, :asc)
  end

  def with_missing_price(inventory) do
    inventory |> Enum.filter(fn x -> x.price == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    inventory |> Enum.map(fn x -> %{x | name: String.replace(x.name, old_word, new_word)} end)
  end

  def increase_quantity(item, count) do
    %{item | quantity_by_size: Map.new(item.quantity_by_size, fn {key, value} -> {key, value + count} end)}
  end

  def total_quantity(item) do
    Map.values(item.quantity_by_size) |> Enum.sum()
  end
end
