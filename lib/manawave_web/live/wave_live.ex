defmodule ManawaveWeb.WaveLive do
  use ManawaveWeb, :live_view
  alias Manawave.Waves

  @impl true
  def mount(%{"floor" => floor, "number" => number}, _session, socket) do
    {:ok, assign(socket, table: floor <> "_" <> number)}
  end

  @impl true
  def handle_event("wave", _, socket) do
    %{table: socket.assigns.table}
    |> save_wave

    broadcast(:wave)

    {:noreply, socket}
  end

  defp broadcast(event) do
    Phoenix.PubSub.broadcast(Manawave.PubSub, "ManaWave", {event})
  end

  defp save_wave(table) do
    Map.put(table, :time, DateTime.now!("Europe/Zurich"))
    |> Waves.create
  end
end
