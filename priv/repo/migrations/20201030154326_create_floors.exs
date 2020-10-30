defmodule Wave.Repo.Migrations.CreateFloors do
  use Ecto.Migration

  def change do
    create table(:floors) do
      add :name, :string

      timestamps()
    end

    create unique_index(:floors, [:name])
  end
end
