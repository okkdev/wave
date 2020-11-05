defmodule WaveWeb.ContactLive do
  use WaveWeb, :live_view
  alias Wave.Tracing
  alias Wave.Tracing.Contact

  @impl true
  def mount(_params, _session, socket) do
    contact_changeset = Tracing.change_contact(%Contact{})
    {:ok, assign(socket, changeset: contact_changeset)}
  end

  @impl true
  def handle_event("validate", %{"contact" => contact_params}, socket) do
    changeset =
      %Contact{}
      |> Tracing.change_contact(contact_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("submit", %{"contact" => contact_params}, socket) do
    case Tracing.create_contact(contact_params) do
      {:ok, _contact} ->
        {
          :noreply,
          socket
          |> put_flash(:info, "Submitted successfully")
          #  |> push_redirect(to: socket.assigns.return_to)
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
