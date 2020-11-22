defmodule Dictionary do
  def random_word do
    word_list()
    |> Enum.random()
  end

  def word_list do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end

  def word_list(length) do
    word_list()
    |> Enum.filter(fn
      word -> String.length(word) == length
    end)
  end
end
