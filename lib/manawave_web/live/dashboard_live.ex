defmodule ManawaveWeb.DashboardLive do
  use ManawaveWeb, :live_view
  alias Manawave.Waves

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: subscribe()

    {:ok, fetch(socket)}
  end

  @impl true
  def handle_info({:wave, _table}, socket) do
    {:noreply, fetch(socket)}
  end

  @impl true
  def handle_event("acknowledge", %{"value" => table}, socket) do
    Waves.acknowledge(table)

    {:noreply, fetch(socket)}
  end

  def subscribe do
    Phoenix.PubSub.subscribe(Manawave.PubSub, "ManaWave")
  end

  defp fetch(socket) do
    assign(socket,
      tables: Waves.list_all(),
      ack: Waves.list_all_acknowledged()
    )
  end
end
