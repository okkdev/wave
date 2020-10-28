defmodule WaveWeb.PageLive do
  use WaveWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:floors, ["-", "EG", "OG", "UG", "AT"])
      |> assign(:current_floor, "-")
      |> assign(:current_table, "-")
      |> assign_tables()

    {:ok, socket}
  end

  @impl true
  def handle_event("update", %{"picker" => %{"floor" => floor, "table" => table}}, socket) do
    {:noreply, assign_tables(socket, floor, table)}
  end

  @impl true
  def handle_event("submit", %{"picker" => %{"floor" => floor, "table" => table}}, socket) do
    {:noreply,
     push_redirect(socket, to: Routes.live_path(socket, WaveWeb.WaveLive, floor, table))}
  end

  defp assign_tables(socket, floor \\ "-", table \\ "-") do
    socket
    |> assign_current_table(floor, table)
    |> set_table_amount(floor)
  end

  defp assign_current_table(socket, floor, table) do
    if socket.assigns.current_floor === floor do
      socket
      |> assign(:current_table, table)
      |> toggle_disable(floor, table)
    else
      socket
      |> assign(:current_floor, floor)
      |> assign(:current_table, "-")
      |> toggle_disable(floor, "-")
    end
  end

  defp set_table_amount(socket, "-") do
    assign(socket, tables: ["-"])
  end

  defp set_table_amount(socket, "EG") do
    assign_table_amount(socket, 1..6)
  end

  defp set_table_amount(socket, "OG") do
    assign_table_amount(socket, 1..7)
  end

  defp set_table_amount(socket, "UG") do
    assign_table_amount(socket, 1..2)
  end

  defp set_table_amount(socket, "AT") do
    assign_table_amount(socket, 1..2)
  end

  defp assign_table_amount(socket, tables) do
    assign(socket, tables: ["-" | Enum.to_list(tables)])
  end

  defp toggle_disable(socket, "-", _) do
    assign(socket, :disabled, true)
  end

  defp toggle_disable(socket, _, table) when table !== "-" do
    assign(socket, :disabled, false)
  end

  defp toggle_disable(socket, _, _) do
    assign(socket, :disabled, true)
  end
end
