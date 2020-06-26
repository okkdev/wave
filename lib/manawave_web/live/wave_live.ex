defmodule ManawaveWeb.WaveLive do
  use ManawaveWeb, :live_view
  alias Manawave.Waves
  alias Manawave.Pubsub

  @impl true
  def mount(%{"floor" => floor, "number" => number}, _session, socket) do
    if connected?(socket), do: Pubsub.subscribe()
    {:ok, assign(socket, table: floor <> "_" <> number, disabled: false, waveani: false)}
  end

  @impl true
  def handle_event("wave", _, socket) do
    %{table: socket.assigns.table}
    |> save_wave

    Pubsub.broadcast(:wave)
    :timer.send_after(300, self(), {:waveani})

    {:noreply, assign(socket, disabled: true, waveani: true)}
  end

  @impl true
  def handle_info({:ready, table}, socket) do
    if table === socket.assigns.table do
      {:noreply, assign(socket, disabled: false)}
    else
      {:noreply, socket}
    end
  end

  @impl true
  def handle_info({:waveani}, socket) do
    {:noreply, assign(socket, waveani: false)}
  end

  @impl true
  def handle_info(_, socket) do
    {:noreply, socket}
  end

  defp save_wave(table) do
    Map.put(table, :time, DateTime.now!("Europe/Zurich"))
    |> Waves.create
  end
end
