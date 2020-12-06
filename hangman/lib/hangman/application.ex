defmodule Hangman.Application do
  use Application

  alias Hangman.{Server, Metadata}

  def start(_type, _args) do
    options = [
      name: Hangman.Supervisor,
      strategy: :one_for_one,
      start: {Server, :start_link, []}
    ]

    Metadata.start_link()
    DynamicSupervisor.start_link(Hangman.Server, [], options)
  end

  def generate_child() do
    %{
      id: Hangman.Server,
      start: {Server, :start_link, []}
    }
  end
end
