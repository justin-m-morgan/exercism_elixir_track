defmodule RationalNumbers do
  @type rational :: {integer, integer}

  import Kernel, except: [abs: 1]

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a_num, a_den}, {b_num, b_den}) do
    numerator = a_num * b_den + a_den * b_num
    denominator = a_den * b_den
    reduce({numerator, denominator})
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a_num, a_den}, {b_num, b_den}) do
    numerator = a_num * b_den - a_den * b_num
    denominator = a_den * b_den
    reduce({numerator, denominator})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a_num, a_den}, {b_num, b_den}) do
    numerator = a_num * b_num
    denominator = a_den * b_den
    reduce({numerator, denominator})
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a_num, a_den}, {b_num, b_den}) do
    numerator = a_num * b_den
    denominator = a_den * b_num
    reduce({numerator, denominator})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({numerator, denominator}) do
    {Kernel.abs(numerator), Kernel.abs(denominator)}
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({numerator, denominator}, n) when n < 0,
    do: pow_rational({denominator, numerator}, Kernel.abs(n))

  def pow_rational({numerator, denominator}, n) do
    {Integer.pow(numerator, n), Integer.pow(denominator, n)}
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {numerator, denominator}) do
    (x * 1.0)
    |> Float.pow(numerator)
    |> Float.pow(1 / denominator)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({numerator, denominator}) when denominator < 0 do
    {-1 * numerator, -1 * denominator}
    |> reduce()
  end

  def reduce({numerator, denominator}) do
    gcd = Integer.gcd(numerator, denominator)

    {div(numerator, gcd), div(denominator, gcd)}
  end
end
