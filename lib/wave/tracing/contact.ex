defmodule Wave.Tracing.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contacts" do
    field :city, :string
    field :firstname, :string
    field :lastname, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:lastname, :firstname, :city, :phone])
    |> validate_required([:lastname, :firstname, :city, :phone])
  end
end
