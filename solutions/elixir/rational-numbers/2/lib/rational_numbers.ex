defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, b1}, {a2, b2}),
    do: reduce({a1 * b2 + a2 * b1, b1 * b2})

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}),
    do: reduce({a1 * b2 - a2 * b1, b1 * b2})

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}),
    do: reduce({a1 * a2, b1 * b2})

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, b1}, {a2, b2}),
    do: reduce({a1 * b2, b1 * a2})

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({n, d}), do: reduce({Kernel.abs(n), Kernel.abs(d)})

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({num, den}, n) do
    cond do
      n > 0 -> reduce({:math.pow(num, n) |> round, :math.pow(den, n) |> round})
      n < 0 -> reduce({:math.pow(den, -n) |> round, :math.pow(num, -n) |> round})
      n == 0 -> {1, 1}
    end
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {num, den}), do: :math.pow(x, num / den)

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce(a) do
    a
    |> then(fn {n, d} -> if d < 0, do: {-n, -d}, else: {n, d} end)
    |> then(fn {n, d} -> {n, d, Integer.gcd(n, d)} end)
    |> then(fn {n, d, gcd} -> {div(n, gcd), div(d, gcd)} end)
  end
end
