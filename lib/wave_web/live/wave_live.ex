defmodule WaveWeb.WaveLive do
  use WaveWeb, :live_view
  alias Wave.Waves
  alias Wave.Pubsub

  @impl true
  def mount(%{"table_id" => table}, _session, socket) do
    if connected?(socket), do: Pubsub.subscribe()

    case Waves.get_table(table) do
      nil ->
        {:ok, push_redirect(socket, to: Routes.page_path(socket, :index))}

      table ->
        socket =
          socket
          |> assign(:table, table)
          |> assign(:disabled, table.active)
          |> assign(:waveani, false)

        {:ok, socket}
    end
  end

  @impl true
  def handle_event("wave", _, socket) do
    Waves.activate_table(socket.assigns.table.id)

    Pubsub.broadcast(:wave)
    :timer.send_after(300, self(), {:waveani})

    socket =
      socket
      |> assign(disabled: true, waveani: true)
      |> put_flash(:info, "🙋‍♀️ Crew wurde gerufen! 🙋‍♂️")

    {:noreply, socket}
  end

  @impl true
  def handle_info({:ready, table}, socket) do
    if table === socket.assigns.table.id do
      socket =
        socket
        |> assign(disabled: false)
        |> put_flash(:info, "Jemand ist auf dem Weg! 🏃‍♂️")

      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end

  @impl true
  def handle_info({:waveani}, socket) do
    {:noreply, assign(socket, waveani: false)}
  end

  @impl true
  def handle_info(_, socket) do
    {:noreply, socket}
  end
end
