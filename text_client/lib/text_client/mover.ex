defmodule TextClient.Mover do
  alias TextClient.State

  def move(game = %State{game_service: game_service, guess: guess}) do
    tally = Hangman.make_move(game_service, guess)
    Map.put(game, :tally, tally)
  end
end
