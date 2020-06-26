defmodule ManawaveWeb.DashboardLive do
  use ManawaveWeb, :live_view
  alias Manawave.Waves

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      subscribe()
      :timer.send_interval(1000, self(), :tick)
    end

    {:ok, fetch(put_time(socket))}
  end

  @impl true
  def handle_info({:wave}, socket) do
    {:noreply, fetch(socket)}
  end

  @impl true
  def handle_info(:tick, socket) do
    {:noreply, put_time(socket)}
  end

  @impl true
  def handle_event("acknowledge", %{"value" => table}, socket) do
    Waves.acknowledge(table)

    {:noreply, fetch(socket)}
  end

  defp subscribe do
    Phoenix.PubSub.subscribe(Manawave.PubSub, "ManaWave")
  end

  defp put_time(socket) do
    assign(socket, currenttime: DateTime.now!("Europe/Zurich"))
  end

  defp fetch(socket) do
    assign(socket,
      tables: Waves.list_all(),
      ack: Waves.list_all_acknowledged()
    )
  end
end
