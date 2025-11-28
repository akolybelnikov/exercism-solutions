defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    {_, numeric_component} = volume_pair
    numeric_component
  end

  def to_milliliter({:cup, amount} = volume_pair) do
    {:milliliter, amount * 240}
  end

  def to_milliliter({:fluid_ounce, amount} = volume_pair) do
    {:milliliter, amount * 30}
  end

  def to_milliliter({:teaspoon, amount} = volume_pair) do
    {:milliliter, amount * 5}
  end

  def to_milliliter({:tablespoon, amount} = volume_pair) do
    {:milliliter, amount * 15}
  end

  def to_milliliter({:milliliter, amount} = volume_pair) do
    {:milliliter, amount}
  end

  def from_milliliter({:milliliter, amount} = volume_pair, :cup = unit) do
    {:cup, amount / 240}
  end

  def from_milliliter({:milliliter, amount} = volume_pair, :fluid_ounce = unit) do
    {:fluid_ounce, amount / 30}
  end

  def from_milliliter({:milliliter, amount} = volume_pair, :teaspoon = unit) do
    {:teaspoon, amount / 5}
  end

  def from_milliliter({:milliliter, amount} = volume_pair, :tablespoon = unit) do
    {:tablespoon, amount / 15}
  end

  def from_milliliter({:milliliter, amount} = volume_pair, :milliliter = unit) do
    {:milliliter, amount}
  end

  def convert(volume_pair, unit) do
    {_, amount} = to_milliliter(volume_pair)
    from_milliliter({:milliliter, amount}, unit)
  end
end
