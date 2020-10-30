defmodule Wave.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table(:tables) do
      add :number, :integer
      add :active, :boolean, default: false, null: false
      add :floor_id, references(:floors, on_delete: :nothing)

      timestamps()
    end

    create index(:tables, [:floor_id])
  end
end
