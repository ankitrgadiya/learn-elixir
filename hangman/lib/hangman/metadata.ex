defmodule Hangman.Metadata do
  @name __MODULE__

  def start_link() do
    Agent.start(fn -> 0 end, name: @name)
  end

  def count_inc() do
    count_update()
    |> return_count()
  end

  defp count_update() do
    Agent.update(@name, fn count -> count + 1 end)
  end

  defp return_count(:ok) do
    Agent.get(@name, fn count -> count end)
  end
end
