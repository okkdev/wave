defmodule WaveWeb.DashboardTracingLive do
  use WaveWeb, :live_view
  alias Wave.Tracing
  alias Wave.Pubsub

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Pubsub.subscribe()
    end

    {:ok, fetch(socket)}
  end

  @impl true
  def handle_info(:trace, socket) do
    {:noreply, fetch(socket)}
  end

  @impl true
  def handle_info(_, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("delete", %{"value" => id}, socket) do
    Tracing.delete_contact(id)
    {:noreply, fetch(socket)}
  end

  defp fetch(socket) do
    assign(socket,
      contacts: Tracing.list_contacts()
    )
  end
end
