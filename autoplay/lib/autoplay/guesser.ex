defmodule Autoplay.Guesser do
  alias Autoplay.State

  def guess(%State{type: :dumb}) do
    Enum.take_random(?a..?z, 1)
    |> to_string()
  end

  def guess(%State{type: :smart, tally: tally}) do
    possible_word(tally.letters)
    |> String.codepoints()
    |> Enum.random()
  end

  defp possible_word(letters) do
    letters
    |> Enum.count()
    |> Dictionary.word_list()
    |> filter_words(letters)
    |> Enum.random()
  end

  defp filter_words(words, letters) do
    Enum.filter(words, fn
      word ->
        word
        |> String.codepoints()
        |> word_matches?(letters)
    end)
  end

  defp word_matches?([], []), do: true

  defp word_matches?([guess_head | guess], [actual_head | actual]) do
    letter_matches?(guess_head, actual_head) && word_matches?(guess, actual)
  end

  defp letter_matches?(_guess, _actual = "_"), do: true
  defp letter_matches?(guess, actual), do: guess == actual
end
