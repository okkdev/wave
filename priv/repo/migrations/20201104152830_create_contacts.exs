defmodule Wave.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :lastname, :string
      add :firstname, :string
      add :city, :string
      add :phone, :string

      timestamps()
    end

  end
end
