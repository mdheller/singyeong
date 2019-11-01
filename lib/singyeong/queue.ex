defmodule Singyeong.Queue do
  @moduledoc """
  A message queue.
  """

  @behaviour RaftedValue.Data

  @base_state %{
    queue: :queue.new(),
    length: 0,
  }

  def new, do: @base_state

  def command(%{queue: queue, length: length} = state, {:push, payload}) do
    {:ok, %{state | queue: :queue.in(payload, queue), length: length + 1}}
  end

  def command(state, :clear) do
    {:ok, @base_state}
  end

  def command(%{queue: queue, length: length} = state, {:pop, metadata}) do
    # TODO: Determine if match, and pop if possible
  end

  def command(%{queue: queue, length: length} = state, {:pop_until, metadata, amount}) do
    # TODO: Fill this out
  end

  def query(state, :size) do
    {{:ok, state[:length]}, state}
  end
end
