defmodule Autoplay do
  alias Autoplay.Player

  defdelegate dumb_play(), to: Player
  defdelegate smart_play(), to: Player
end
