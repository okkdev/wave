defmodule ManawaveWeb.PageLive do
  use ManawaveWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:floors, ["-", "EG", "OG", "UG", "AT"])
      |> assign_tables("-")

    {:ok, socket}
  end

  @impl true
  def handle_event("floor", %{"picker" => %{"floor" => floor}}, socket) do
    {:noreply, assign_tables(socket, floor)}
  end

  @impl true
  def handle_event("submit", %{"picker" => %{"floor" => floor, "table" => table}}, socket) do
    {:noreply,
     push_redirect(socket, to: Routes.live_path(socket, ManawaveWeb.WaveLive, floor, table))}
  end

  defp assign_tables(socket, floor) do
    socket
    |> toggle_disable(floor)
    |> set_table_amount(floor)
    |> assign(:current_floor, floor)
  end

  defp set_table_amount(socket, "-") do
    assign(socket, tables: ["-"])
  end

  defp set_table_amount(socket, "EG") do
    assign(socket, tables: Enum.to_list(1..6))
  end

  defp set_table_amount(socket, "OG") do
    assign(socket, tables: Enum.to_list(1..7))
  end

  defp set_table_amount(socket, "UG") do
    assign(socket, tables: Enum.to_list(1..2))
  end

  defp set_table_amount(socket, "AT") do
    assign(socket, tables: Enum.to_list(1..2))
  end

  defp toggle_disable(socket, "-") do
    assign(socket, :disabled, true)
  end

  defp toggle_disable(socket, _) do
    assign(socket, :disabled, false)
  end
end
