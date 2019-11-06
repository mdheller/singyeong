defmodule Singyeong.MessageDispatcher do
  @moduledoc """
  The message dispatcher is responsible for sending messages to a set of
  client pids inside of an application id.
  """

  alias Singyeong.Gateway.Payload
  alias Singyeong.MnesiaStore

  def register_socket(app_id, client_id, socket) do
    MnesiaStore.add_socket app_id, client_id, socket.transport_pid
  end
  def unregister_socket(socket) do
    MnesiaStore.remove_socket socket.assigns[:app_id], socket.assigns[:client_id]
  end

  def send_dispatch(app_id, clients, msg) do
    clients
    |> Enum.map(fn client ->
      {:ok, pid} = MnesiaStore.get_socket app_id, client
      pid
    end)
    |> Enum.filter(fn pid ->
      pid != nil
    end)
    |> Enum.filter(fn pid ->
      Process.alive? pid
    end)
    |> Enum.each(fn pid ->
      send pid, Payload.create_payload(:dispatch, %{
        "nonce" => msg["nonce"],
        "payload" => msg["payload"],
      })
    end)
  end
end
