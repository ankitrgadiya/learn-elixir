defmodule Procs do
  def greeter(count) do
    receive do
      {:add, n} ->
        greeter(count + n)

      {:reset} ->
        greeter(0)

      msg ->
        IO.puts("#{count}: #{msg}")
        greeter(count + 1)
    end
  end
end
