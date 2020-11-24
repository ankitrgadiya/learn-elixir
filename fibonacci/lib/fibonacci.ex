defmodule Fibonacci do
  alias Fibonacci.Calculate

  defdelegate fib(n), to: Calculate
end
