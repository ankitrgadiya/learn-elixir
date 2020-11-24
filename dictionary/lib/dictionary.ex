defmodule Dictionary do
  alias Dictionary.WordList

  defdelegate start(), to: WordList

  defdelegate random_word(dictionary), to: WordList

  defdelegate word_list(length, dictionary), to: WordList
end
