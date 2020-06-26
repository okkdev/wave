defmodule ManawaveWeb.PageLive do
  use ManawaveWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event("submit", %{"table" => ""}, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("submit", %{"floor" => floor, "table" => table}, socket) do
    {:noreply, push_redirect(socket, to: Routes.live_path(socket, ManawaveWeb.WaveLive, floor, table))}
  end
end
