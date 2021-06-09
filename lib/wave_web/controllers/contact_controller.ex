defmodule WaveWeb.ContactController do
  use WaveWeb, :controller
  alias Wave.Tracing
  alias Wave.Tracing.Contact
  alias Wave.Pubsub

  def index(conn, _params) do
    conn
    |> assign(:changeset, Tracing.change_contact(%Contact{}))
    |> render("index.html")
  end

  def create(conn, %{"contact" => contact_params}) do
    case Tracing.create_contact(contact_params) do
      {:ok, _contact} ->
        Pubsub.broadcast(:trace)

        conn
        |> put_flash(:info, "You are now T R A C E D 👁")
        |> put_session(:traced, true)
        |> redirect(to: "/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end
end
