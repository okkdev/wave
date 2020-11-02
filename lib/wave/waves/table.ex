defmodule Wave.Waves.Table do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tables" do
    field :active, :boolean, default: false
    field :number, :integer
    field :floor_id, :id

    timestamps()
  end

  @doc false
  def changeset(table, attrs) do
    table
    |> cast(attrs, [:number, :active, :floor_id])
    |> validate_required([:number, :active, :floor_id])
  end
end
