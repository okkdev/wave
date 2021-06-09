defmodule Wave.Waves.Table do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wave.Waves.Floor

  schema "tables" do
    field :active, :boolean, default: false
    field :number, :integer
    belongs_to :floor, Floor

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(table, attrs) do
    table
    |> cast(attrs, [:number, :active])
    |> validate_required([:number, :active])
  end
end
