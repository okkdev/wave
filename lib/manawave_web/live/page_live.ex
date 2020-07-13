defmodule ManawaveWeb.PageLive do
  use ManawaveWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, set_table_number(socket, "EG")}
  end

  @impl true
  def handle_event("floor", %{"floor" => floor}, socket) do
    {:noreply, set_table_number(socket, floor)}
  end

  @impl true
  def handle_event("submit", %{"floor" => floor, "table" => table}, socket) do
    {:noreply, push_redirect(socket, to: Routes.live_path(socket, ManawaveWeb.WaveLive, floor, table))}
  end

  defp set_table_number(socket, "EG") do
    assign(socket, table_num: Enum.to_list(1..6))
  end

  defp set_table_number(socket, "OG") do
    assign(socket, table_num: Enum.to_list(1..7))
  end

  defp set_table_number(socket, "UG") do
    assign(socket, table_num: Enum.to_list(1..2))
  end

  defp set_table_number(socket, "OD") do
    assign(socket, table_num: Enum.to_list(1..2))
  end
end
