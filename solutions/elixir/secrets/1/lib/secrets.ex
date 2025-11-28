defmodule Secrets do
  @doc """
  Returns a function that adds the secret to its input.
  """
  @spec secret_add(integer()) :: (integer() -> integer())
  def secret_add(secret), do: &(&1 + secret)
  @doc """
  Returns a function that subtracts the secret from its input.
  """
  @spec secret_subtract(integer()) :: (integer() -> integer())
  def secret_subtract(secret), do: &(&1 - secret)

  @doc """
  Returns a function that multiplies its input by the secret.
  """
  @spec secret_multiply(integer()) :: (integer() -> integer())
  def secret_multiply(secret), do: &(&1 * secret)

  @doc """
  Returns a function that divides its input by the secret.
  """
  @spec secret_divide(integer()) :: (integer() -> integer())
  def secret_divide(secret), do: &(div(&1, secret))

  @doc """
  Returns a function that performs a bitwise AND with the secret.
  """
  @spec secret_and(integer()) :: (integer() -> integer())
  def secret_and(secret), do: &(Bitwise.band(&1,secret))

  @doc """
  Returns a function that performs a bitwise XOR with the secret.
  """
  @spec secret_xor(integer()) :: (integer() -> integer())
  def secret_xor(secret), do: &(Bitwise.bxor(&1, secret))

  @doc """
  Returns a function that combines two secret functions.
  """
  @spec secret_combine((integer() -> integer()), (integer() -> integer())) :: (integer() -> integer())
  def secret_combine(secret_function1, secret_function2), do: &(secret_function2.(secret_function1.(&1)))
end
