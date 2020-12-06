defmodule Chain do
  defstruct(
    next_node: nil,
    count: 1000
  )

  def start_link(next_node) do
    spawn_link(Chain, :message_loop, [%Chain{next_node: next_node}])
    |> Process.register(:chainer)
  end

  def message_loop(%Chain{count: 0}) do
    IO.puts("Done!")
  end

  def message_loop(state) do
    receive do
      {:trigger, _list} ->
        send({:chainer, state.next_node}, {:trigger, []})

        Map.put(state, :count, state.count - 1)
        |> message_loop()

      count ->
        Map.put(state, :count, count)
        |> message_loop()
    end
  end
end
