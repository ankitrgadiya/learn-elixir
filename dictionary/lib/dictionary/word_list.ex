defmodule Dictionary.WordList do
  @name __MODULE__

  def start_link() do
    Agent.start_link(&initialize/0, name: @name)
  end

  def initialize() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end

  def random_word() do
    Agent.get(@name, &Enum.random/1)
  end

  def word_list(length) do
    Agent.get(@name, & &1)
    |> Enum.filter(fn word -> String.length(word) == length end)
  end
end
