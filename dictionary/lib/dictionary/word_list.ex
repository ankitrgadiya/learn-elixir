defmodule Dictionary.WordList do
  def start() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end

  def random_word(dictionary) do
    dictionary
    |> Enum.random()
  end

  def word_list(length, dictionary) do
    dictionary
    |> Enum.filter(fn word -> String.length(word) == length end)
  end
end
