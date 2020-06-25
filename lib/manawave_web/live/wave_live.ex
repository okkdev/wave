defmodule ManawaveWeb.WaveLive do
  use ManawaveWeb, :live_view
  alias Manawave.Waves

  @impl true
  def mount(%{"id" => table}, _session, socket) do
    {:ok, assign(socket, table: table)}
  end

  @impl true
  def handle_event("wave", _, socket) do
    %{number: socket.assigns.table}
    |> save_wave
    |> broadcast(:wave)

    {:noreply, socket}
  end

  defp broadcast(table, event) do
    Phoenix.PubSub.broadcast(Manawave.PubSub, "ManaWave", {event, table})
  end

  defp save_wave(table) do
    table_with_time = Map.put(table, :time, DateTime.now!("Europe/Zurich"))
    Waves.create(table_with_time)
    table_with_time
  end
end
