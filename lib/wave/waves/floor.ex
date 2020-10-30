defmodule Wave.Waves.Floor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "floors" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(floor, attrs) do
    floor
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
