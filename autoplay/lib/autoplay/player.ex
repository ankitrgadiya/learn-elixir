defmodule Autoplay.Player do
  alias Autoplay.{State, Guesser, Summary}

  def dumb_play() do
    start(:dumb)
  end

  def smart_play() do
    start(:smart)
  end

  defp start(type) when type in [:dumb, :smart] do
    Hangman.new_game()
    |> setup_game(type)
    |> play()
  end

  defp setup_game(game, type) do
    %State{
      game_service: game,
      tally: Hangman.tally(game),
      type: type
    }
  end

  defp play(%State{tally: %{game_state: :won}}) do
    exit_with_message("I WON!")
  end

  defp play(%State{tally: %{game_state: :lost}}) do
    exit_with_message("How did I lose 😕")
  end

  defp play(game) do
    game
    |> make_move()
    |> Summary.display()
    |> play()
  end

  defp make_move(game = %{game_service: game_service}) do
    guess = Guesser.guess(game)
    tally = Hangman.make_move(game_service, guess)
    Map.put(game, :tally, tally)
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end
