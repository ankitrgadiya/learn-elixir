defmodule Fibonacci.Cache do
  def start() do
    {:ok, pid} = Agent.start(fn -> Map.new() end)
    pid
  end

  def stop(agent) do
    agent
    |> Agent.stop(:normal)
  end

  def get(agent, key) do
    agent
    |> Agent.get(fn state -> Map.get(state, key) end)
  end

  def set(agent, key, value) do
    agent
    |> Agent.update(fn state -> Map.put(state, key, value) end)
  end
end
