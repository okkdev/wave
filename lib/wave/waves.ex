defmodule Wave.Waves do
  @moduledoc """
  The Waves context.
  """

  import Ecto.Query, warn: false
  alias Wave.Repo

  alias Wave.Waves.Floor

  @doc """
  Returns the list of floors.

  ## Examples

      iex> list_floors()
      [%Floor{}, ...]

  """
  def list_floors do
    Repo.all(Floor)
  end

  @doc """
  Gets a single floor.

  Raises `Ecto.NoResultsError` if the Floor does not exist.

  ## Examples

      iex> get_floor!(123)
      %Floor{}

      iex> get_floor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_floor!(id), do: Repo.get!(Floor, id)

  @doc """
  Creates a floor.

  ## Examples

      iex> create_floor(%{field: value})
      {:ok, %Floor{}}

      iex> create_floor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_floor(attrs \\ %{}) do
    %Floor{}
    |> Floor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a floor.

  ## Examples

      iex> update_floor(floor, %{field: new_value})
      {:ok, %Floor{}}

      iex> update_floor(floor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_floor(%Floor{} = floor, attrs) do
    floor
    |> Floor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a floor.

  ## Examples

      iex> delete_floor(floor)
      {:ok, %Floor{}}

      iex> delete_floor(floor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_floor(%Floor{} = floor) do
    Repo.delete(floor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking floor changes.

  ## Examples

      iex> change_floor(floor)
      %Ecto.Changeset{data: %Floor{}}

  """
  def change_floor(%Floor{} = floor, attrs \\ %{}) do
    Floor.changeset(floor, attrs)
  end

  alias Wave.Waves.Table

  @doc """
  Returns the list of tables.

  ## Examples

      iex> list_tables()
      [%Table{}, ...]

  """
  def list_tables do
    Repo.all(Table)
  end

  @doc """
  Gets a single table.

  Raises `Ecto.NoResultsError` if the Table does not exist.

  ## Examples

      iex> get_table!(123)
      %Table{}

      iex> get_table!(456)
      ** (Ecto.NoResultsError)

  """
  def get_table!(id), do: Repo.get!(Table, id)

  @doc """
  Creates a table.

  ## Examples

      iex> create_table(%{field: value})
      {:ok, %Table{}}

      iex> create_table(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_table(attrs \\ %{}) do
    %Table{}
    |> Table.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates multiple tables.
  """
  def create_tables(floor_id, tables) do
    Enum.each(1..tables, fn table_number ->
      %Table{}
      |> Table.changeset(%{number: table_number, floor_id: floor_id})
      |> Repo.insert()
    end)
  end

  @doc """
  Updates a table.

  ## Examples

      iex> update_table(table, %{field: new_value})
      {:ok, %Table{}}

      iex> update_table(table, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_table(%Table{} = table, attrs) do
    table
    |> Table.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a table.

  ## Examples

      iex> delete_table(table)
      {:ok, %Table{}}

      iex> delete_table(table)
      {:error, %Ecto.Changeset{}}

  """
  def delete_table(%Table{} = table) do
    Repo.delete(table)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking table changes.

  ## Examples

      iex> change_table(table)
      %Ecto.Changeset{data: %Table{}}

  """
  def change_table(%Table{} = table, attrs \\ %{}) do
    Table.changeset(table, attrs)
  end
end
