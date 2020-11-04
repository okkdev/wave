# defmodule WaveWeb.DashboardLive do
#   use WaveWeb, :live_view
#   alias Wave.Waves
#   alias Wave.Pubsub

#   @impl true
#   def mount(_params, _session, socket) do
#     if connected?(socket) do
#       Pubsub.subscribe()
#       :timer.send_interval(1000, self(), :tick)
#     end

#     {:ok, fetch(put_time(socket))}
#   end

#   @impl true
#   def handle_info({:wave}, socket) do
#     {:noreply, fetch(socket)}
#   end

#   @impl true
#   def handle_info(:tick, socket) do
#     {:noreply, put_time(socket)}
#   end

#   @impl true
#   def handle_info(_, socket) do
#     {:noreply, socket}
#   end

#   @impl true
#   def handle_event("acknowledge", %{"value" => table}, socket) do
#     Waves.acknowledge(table)
#     Pubsub.broadcast(:ready, table)
#     {:noreply, fetch(socket)}
#   end

#   defp put_time(socket) do
#     assign(socket, currenttime: DateTime.now!("Europe/Zurich"))
#   end

#   defp fetch(socket) do
#     assign(socket,
#       tables: Waves.list_all(),
#       ack: Waves.list_all_acknowledged()
#     )
#   end
# end
