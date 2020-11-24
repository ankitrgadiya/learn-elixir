defmodule Fibonacci.Calculate do
  alias Fibonacci.Cache

  def fib(n) do
    cache = Cache.start()
    ans = fib_calc(cache, 0, n)
    Cache.stop(cache)
    ans
  end

  defp fib_calc(cache, n, n) do
    calculate_current(cache, n)
  end

  defp fib_calc(cache, current, n) do
    val = calculate_current(cache, current)
    Cache.set(cache, current, val)
    fib_calc(cache, current + 1, n)
  end

  defp calculate_current(_cache, current) when current in [0, 1], do: current

  defp calculate_current(cache, current) do
    Cache.get(cache, current - 2) + Cache.get(cache, current - 1)
  end
end
