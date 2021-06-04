defmodule WaveWeb.DashboardLive do
  use WaveWeb, :live_view
  alias Wave.Waves
  alias Wave.Pubsub

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Pubsub.subscribe()
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
    assign(socket, current_time: NaiveDateTime.utc_now())
  end

  defp fetch(socket) do
    assign(socket,
      tables: Waves.list_active_tables(),
      ack: Waves.list_inactive_tables()
    )
  end

  # Improve this shit
  defp naive_to_zurich_time(naive_time) do
    naive_time
    |> DateTime.from_naive!("Etc/UTC")
    |> DateTime.shift_zone!("Europe/Zurich")
    |> DateTime.truncate(:second)
    |> DateTime.to_time()
  end
end
