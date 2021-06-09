defmodule WaveWeb.PageLive do
  use WaveWeb, :live_view
  alias Wave.Waves

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:floors, Waves.list_floors() |> Enum.map(&{&1.name, &1.id}))
      |> assign(:tables, [])
      |> assign(:current_floor, "")
      |> assign(:disabled, true)

    {:ok, socket}
  end

  @impl true
  def handle_event(
        "update",
        %{"_target" => ["picker", "floor"], "picker" => %{"floor" => floor}},
        socket
      )
      when floor == "" do
    {:noreply, assign(socket, :current_floor, floor)}
  end

  @impl true
  def handle_event(
        "update",
        %{"_target" => ["picker", "floor"], "picker" => %{"floor" => floor}},
        socket
      ) do
    tables =
      floor
      |> Waves.list_floor_tables()
      |> Enum.map(&{&1.number, &1.id})

    socket =
      socket
      |> assign(:tables, tables)
      |> assign(:current_floor, floor)

    {:noreply, socket}
  end

  @impl true
  def handle_event("submit", %{"picker" => %{"table" => table}}, socket) do
    {:noreply, push_redirect(socket, to: Routes.live_path(socket, WaveWeb.WaveLive, table))}
  end

  @impl true
  def handle_event(_, _, socket) do
    {:noreply, socket}
  end
end
