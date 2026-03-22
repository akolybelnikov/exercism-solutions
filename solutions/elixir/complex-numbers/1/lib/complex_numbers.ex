defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: number
  def real({a, _b}) do
    a
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: number
  def imaginary({_a, b}) do
    b
  end

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | number, b :: complex | number) :: complex
  def mul({a, b}, {c, d}) do
    {a * c - b * d, a * d + b * c}
  end

  def mul({a, b}, c) when is_number(c) do
    {a * c, b * c}
  end

  def mul(a, {c, d}) when is_number(a) do
    {a * c, a * d}
  end

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | number, b :: complex | number) :: complex
  def add({a, b}, {c, d}) do
    {a + c, b + d}
  end

  def add({a, b}, c) when is_number(c) do
    {a + c, b}
  end

  def add(a, {c, d}) when is_number(a) do
    {a + c, d}
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | number, b :: complex | number) :: complex
  def sub({a, b}, {c, d}) do
    {a - c, b - d}
  end

  def sub({a, b}, c) when is_number(c) do
    {a - c, b}
  end

  def sub(a, {c, d}) when is_number(a) do
    {a - c, -d}
  end

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | number, b :: complex | number) :: complex
  def div({a, b}, {c, d}) do
    denom = c * c + d * d
    {(a * c + b * d) / denom, (b * c - a * d) / denom}
  end

  def div({a, b}, c) when is_number(c) do
    {a / c, b / c}
  end

  def div(a, {c, d}) when is_number(a) do
    denom = c * c + d * d
    {a * c / denom, -a * d / denom}
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: number
  def abs({a, b}) do
    :math.sqrt(a * a + b * b)
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({a, b}) do
    {a, -b}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({a, b}) do
    {:math.exp(a) * :math.cos(b), :math.exp(a) * :math.sin(b)}
  end
end
