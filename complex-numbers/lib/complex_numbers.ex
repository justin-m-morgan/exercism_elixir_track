defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {float, float}

  @eulers_constant 2.7182818284590452353602874

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: float
  def real({real, _imaginary}) do
    real
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: float
  def imaginary({_real, imaginary}) do
    imaginary
  end

  @doc """
  Multiply two complex numbers
  """
  @spec mul(a :: complex, b :: complex) :: complex
  def mul({a, b}, {c, d}) do
    real = (a * c) - (b * d)
    imag = (b * c + a * d)
    {real, imag}
  end

  @doc """
  Add two complex numbers
  """
  @spec add(a :: complex, b :: complex) :: complex
  def add({a, b}, {c, d}) do
    {a + c, b + d}
  end

  @doc """
  Subtract two complex numbers
  """
  @spec sub(a :: complex, b :: complex) :: complex
  def sub({a, b}, {c, d}) do
    {a - c, b - d}
  end

  @doc """
  Divide two complex numbers
  """
  @spec div(a :: complex, b :: complex) :: complex
  def div({a, b}, {c, d}) do
    real = (a * c + b * d) / (Float.pow(1.0 * c, 2) + Float.pow(1.0 * d, 2))
    imag = (b * c - a * d) / (Float.pow(1.0 * c, 2) + Float.pow(1.0 * d, 2))
    {real, imag}
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: float
  def abs({a, b}) do
    base = (Integer.pow(a, 2) + Integer.pow(b, 2)) * 1.0
    Float.pow(base, 0.5)
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({a, b}) do
    {a, -1.0 * b}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({a, b}) do
    a = {:math.pow(@eulers_constant, a), 0}
    eul = {:math.cos(b), :math.sin(b)}
    mul(a, eul)
  end
end
