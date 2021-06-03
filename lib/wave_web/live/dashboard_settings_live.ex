defmodule WaveWeb.DashboardSettingsLive do
  use WaveWeb, :live_view

  alias Wave.Waves

  @impl Phoenix.LiveView
  def handle_event("create_floor", %{"name" => name, "tables" => tables}, socket) do
    {tables, _} = Integer.parse(tables)

    create_floor_with_tables(name, tables)
    {:noreply, socket}
  end

  defp create_floor_with_tables(name, number_of_tables) do
    tables = for tn <- 1..number_of_tables, do: %{number: tn, active: false}

    Waves.create_floor(%{name: name, tables: tables})
  end
end
