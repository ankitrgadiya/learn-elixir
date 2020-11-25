defmodule Cache.Application do
  use Application

  alias Cache.Impl

  def start(_type, _args) do
    Impl.start_link()
  end
end
