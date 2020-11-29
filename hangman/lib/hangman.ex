defmodule Hangman do
  alias Hangman.Application

  def new_game() do
    child = Application.generate_child()
    {:ok, pid} = DynamicSupervisor.start_child(Hangman.Supervisor, child)
    pid
  end

  def tally(game_pid) do
    GenServer.call(game_pid, {:tally})
  end

  def make_move(game_pid, guess) do
    GenServer.call(game_pid, {:make_move, guess})
  end
end
