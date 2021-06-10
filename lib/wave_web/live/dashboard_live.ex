defmodule WaveWeb.DashboardLive do
  use WaveWeb, :live_view
  alias Wave.Waves
  alias Wave.Pubsub

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Pubsub.subscribe()
      schedule_tick()
    end

    socket =
      socket
      |> put_time()
      |> assign(flashbang: false)
      |> fetch()

    {:ok, socket}
  end

  @impl true
  def handle_info(:wave, socket) do
    socket =
      socket
      |> flashbang()
      |> fetch()

    {:noreply, socket}
  end

  @impl true
  def handle_info(:tick, socket) do
    schedule_tick()
    {:noreply, put_time(socket)}
  end

  @impl true
  def handle_info(:remove_flashbang, socket) do
    {:noreply, assign(socket, flashbang: false)}
  end

  @impl true
  def handle_info(_, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("acknowledge", %{"id" => table}, socket) do
    table = String.to_integer(table)
    Waves.acknowledge_table(table)
    Pubsub.broadcast(:ready, table)
    {:noreply, fetch(socket)}
  end

  defp put_time(socket) do
    assign(socket, current_time: DateTime.utc_now())
  end

  defp schedule_tick do
    Process.send_after(self(), :tick, 1000)
  end

  defp flashbang(socket) do
    Process.send_after(self(), :remove_flashbang, 300)
    assign(socket, flashbang: true)
  end

  defp fetch(socket) do
    assign(socket,
      tables: Waves.list_active_tables(),
      ack: Waves.list_inactive_tables()
    )
  end

  # TODO: env var for timezone
  defp to_time(time) do
    time
    |> DateTime.shift_zone!(Application.fetch_env!(:wave, :timezone))
    |> DateTime.truncate(:second)
    |> DateTime.to_time()
  end
end
