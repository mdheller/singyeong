defmodule Singyeong.Discovery do
  @moduledoc """
  When a service connects to singyeong, it provides a name to identify what it
  is. However, clients may not want to hardcode these application ids or
  otherwise provide them in application config. Thus, singyeong provides an
  interface for discovering services based on metadata.
  """

  alias Singyeong.MnesiaStore

  @doc """
  Find a list of app ids based on the tags being searched for. This function
  will return a list of app ids where *each app id has clients that match the
  given tags*. Importantly, **this does not guarantee that every client of that
  app id has the same tags**.
  """
  @spec discover_service(list()) :: {:ok, list()} | {:error, {binary(), tuple()}}
  def discover_service(tags) do
    # Don't you love it when the solution to a problem is so simple?
    # ^^;
    MnesiaStore.get_applications_with_tags tags
  end
end
