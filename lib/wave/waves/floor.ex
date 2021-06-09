defmodule Wave.Waves.Floor do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wave.Waves.Table

  schema "floors" do
    field :name, :string
    has_many :tables, Table, on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(floor, attrs) do
    floor
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
