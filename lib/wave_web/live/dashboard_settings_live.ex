defmodule WaveWeb.DashboardSettingsLive do
  use WaveWeb, :live_view

  alias Wave.Waves

  @impl true
  def mount(_params, _session, socket) do
    {:ok, fetch(socket)}
  end

  @impl Phoenix.LiveView
  def handle_event("create_floor", %{"name" => name, "tables" => tables}, socket) do
    {tables, _} = Integer.parse(tables)

    create_floor_with_tables(name, tables)
    {:noreply, fetch(socket)}
  end

  @impl true
  def handle_event("delete", %{"value" => id}, socket) do
    Waves.delete_floor(id)
    {:noreply, fetch(socket)}
  end

  defp create_floor_with_tables(name, number_of_tables) do
    tables = for tn <- 1..number_of_tables, do: %{number: tn, active: false}

    Waves.create_floor(%{name: name, tables: tables})
  end

  defp fetch(socket) do
    assign(socket,
      floors: Waves.list_floors()
    )
  end
end
