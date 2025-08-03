defmodule Rational do
  @moduledoc """
  Module for working with rational numbers.
  Represents a fraction as {numerator, denominator} in reduced form.
  """

  @type t :: {integer, pos_integer}

  @doc """
  Creates a rational number from numerator and denominator.
  Automatically reduces the fraction and ensures standard form (denominator > 0).
  """
  @spec new(integer, integer) :: t
  def new(_numerator, 0), do: raise(ArgumentError, "denominator cannot be zero")
  def new(numerator, denominator) when is_integer(numerator) and is_integer(denominator) do
    reduce(numerator, denominator)
  end

  @spec new(integer) :: t
  def new(value) when is_integer(value), do: {value, 1}

  @doc """
  Adds two rational numbers.
  """
  @spec add(t, t) :: t
  def add({n1, d1}, {n2, d2}) do
    reduce(n1 * d2 + n2 * d1, d1 * d2)
  end

  @doc """
  Subtracts two rational numbers.
  """
  @spec subtract(t, t) :: t
  def subtract({n1, d1}, {n2, d2}) do
    reduce(n1 * d2 - n2 * d1, d1 * d2)
  end

  @doc """
  Multiplies two rational numbers.
  """
  @spec multiply(t, t) :: t
  def multiply({n1, d1}, {n2, d2}) do
    reduce(n1 * n2, d1 * d2)
  end

  @doc """
  Divides two rational numbers.
  """
  @spec divide(t, t) :: t
  def divide({n1, d1}, {n2, d2}) do
    if n2 == 0 do
      raise(ArgumentError, "division by zero")
    end
    reduce(n1 * d2, d1 * n2)
  end

  @doc """
  Raises a rational number to an integer power.
  """
  @spec pow(t, integer) :: t
  def pow({n, d}, exp) when exp > 0 do
    reduce(Integer.pow(n, exp), Integer.pow(d, exp))
  end

  def pow({n, d}, exp) when exp < 0 do
    abs_exp = abs(exp)
    reduce(Integer.pow(d, abs_exp), Integer.pow(n, abs_exp))
  end

  def pow(_rational, 0), do: {1, 1}

  # Reduces the fraction by dividing both numerator and denominator by their GCD.
  defp reduce(numerator, denominator) do
    g = gcd(abs(numerator), abs(denominator))
    to_standard_form(div(numerator, g), div(denominator, g))
  end

  # Ensures the denominator is positive.
  defp to_standard_form(numerator, denominator) do
    if denominator < 0 do
      {-numerator, -denominator}
    else
      {numerator, denominator}
    end
  end

  # Calculates the greatest common divisor (GCD) of two integers.
  defp gcd(a, 0), do: a
  defp gcd(a, b), do: gcd(b, rem(a, b))
end
