defmodule GameTest do
  use ExUnit.Case
  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()
    word = List.to_string(game.letters)

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    assert word =~ ~r/^[a-z]*$/
    assert word == String.downcase(word, :ascii)
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert {^game, _tally} = Game.make_move(game, "x")
    end
  end

  test "first occurence of letter is not already used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurence of letter is not already used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game = Game.new_game("wibble")

    fun = fn {guess, state}, game ->
      {game, _tally} = Game.make_move(game, guess)
      assert game.game_state == state
      game
    end

    _moves =
      [
        {"w", :good_guess},
        {"i", :good_guess},
        {"b", :good_guess},
        {"l", :good_guess},
        {"e", :won}
      ]
      |> Enum.reduce(game, fun)
  end

  test "bad guess is recognized" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "lost game is recognized" do
    game = Game.new_game("w")

    fun = fn
      {guess, state = :bad_guess, turns_left}, game ->
        {game, _tally} = Game.make_move(game, guess)
        assert game.game_state == state
        assert game.turns_left == turns_left
        game

      {guess, state = :lost}, game ->
        {game, _tally} = Game.make_move(game, guess)
        assert game.game_state == state
        game
    end

    _moves =
      [
        {"a", :bad_guess, 6},
        {"b", :bad_guess, 5},
        {"c", :bad_guess, 4},
        {"d", :bad_guess, 3},
        {"e", :bad_guess, 2},
        {"f", :bad_guess, 1},
        {"g", :lost}
      ]
      |> Enum.reduce(game, fun)
  end
end
