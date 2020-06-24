defmodule ManawaveWeb.WaveLive do
  use ManawaveWeb, :live_view

  @impl true
  def mount(%{"id" => table}, _session, socket) do
    {:ok, assign(socket, table: table)}
  end

  @impl true
  def handle_event("wave", _, socket) do
    %{:number => socket.assigns.table}
    |> broadcast(:wave)

    {:noreply, socket}
  end

  defp broadcast(table, event) do
    Phoenix.PubSub.broadcast(Manawave.PubSub, "ManaWave", {event, table})
  end
end
