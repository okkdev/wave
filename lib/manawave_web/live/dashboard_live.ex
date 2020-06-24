defmodule ManawaveWeb.DashboardLive do
  use ManawaveWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: subscribe()

    {:ok, assign(socket, :tables, [])}
  end

  @impl true
  def handle_info({:wave, table}, socket) do
    {:noreply, update(socket, :tables, fn tables -> [table | tables] end)}
  end

  def subscribe do
    Phoenix.PubSub.subscribe(Manawave.PubSub, "ManaWave")
  end
end
