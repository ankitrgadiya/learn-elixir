defmodule Cache.Impl do
  @name __MODULE__

  def start_link() do
    Agent.start(fn -> Map.new() end, name: @name)
  end

  def get(key) do
    Agent.get(@name, fn state -> Map.get(state, key) end)
  end

  def set(key, value) do
    Agent.update(@name, fn state -> Map.put(state, key, value) end)
  end

  def has?(key) do
    Agent.get(@name, fn state -> Map.has_key?(state, key) end)
  end
end
