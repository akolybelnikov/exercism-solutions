defmodule Lasagna do
  @doc """
  Returns the expected minutes in the oven for lasagna.
  """
  @spec expected_minutes_in_oven :: Integer.t()
  def expected_minutes_in_oven(), do: 40

  @doc """
  Returns the remaining minutes in the oven for lasagna.
  """
  @spec remaining_minutes_in_oven(Integer.t()) :: Integer.t()
  def remaining_minutes_in_oven(x), do: expected_minutes_in_oven() - x

  @doc """
  Returns the preparation time in minutes for the given number of layers.
  """
  @spec preparation_time_in_minutes(Integer.t()) :: Integer.t()
  def preparation_time_in_minutes(x), do: x * 2

  @doc """
  Returns the total time in minutes for preparation and cooking.
  """
  @spec total_time_in_minutes(Integer.t(), Integer.t()) :: Integer.t()
  def total_time_in_minutes(x, y), do: preparation_time_in_minutes(x) + y

  @doc """
  Returns the alarm sound when the lasagna is done.
  """
  @spec alarm :: String.t()
  def alarm(), do: "Ding!"

end
