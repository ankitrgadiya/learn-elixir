defmodule Fibonacci.Calculate do
  def fib(n) do
    fib_calc(0, n)
  end

  defp fib_calc(n, n) do
    calculate_current(n, Cache.has?(n))
  end

  defp fib_calc(current, n) do
    val = calculate_current(current, Cache.has?(current))
    Cache.set(current, val)
    fib_calc(current + 1, n)
  end

  defp calculate_current(current, _) when current in [0, 1], do: current

  defp calculate_current(current, _is_cached = true), do: Cache.get(current)

  defp calculate_current(current, _not_cached) do
    Cache.get(current - 2) + Cache.get(current - 1)
  end
end
