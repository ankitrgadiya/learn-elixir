defmodule Cache do
  alias Cache.Impl

  defdelegate get(key), to: Impl

  defdelegate set(key, value), to: Impl

  defdelegate has?(key), to: Impl
end
