defmodule Wave.Waves do
  @moduledoc """
  The Waves context.
  """

  import Ecto.Query, warn: false
  alias Wave.Repo
  alias Wave.Waves.{Floor, Table}

  @doc """
  Returns the list of floors.

  ## Examples

      iex> list_floors()
      [%Floor{}, ...]

  """
  def list_floors do
    Floor
    |> Repo.all()
    |> Repo.preload(:tables)
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
  def get_floor!(id) do
    Floor
    |> Repo.get!(id)
    |> Repo.preload(:tables)
  end

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
    |> Ecto.Changeset.cast_assoc(:tables, with: &Table.changeset/2)
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
    |> Ecto.Changeset.cast_assoc(:tables, with: &Table.changeset/2)
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

  def delete_floor(id) do
    get_floor!(id)
    |> Repo.delete()
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

  def acknowledge_table(table) do
    table
    |> get_table!()
    |> change_table(%{active: false})
    |> Repo.update()
  end

  def activate_table(table) do
    table
    |> get_table!()
    |> change_table(%{active: true})
    |> Repo.update()
  end

  @doc """
  Returns the list of tables.

  ## Examples

      iex> list_tables()
      [%Table{}, ...]

  """
  def list_tables do
    Table
    |> Repo.all()
    |> Repo.preload(:floor)
  end

  def list_floor_tables(floor_id) do
    Table
    |> where(floor_id: ^floor_id)
    |> Repo.all()
    |> Repo.preload(:floor)
  end

  def list_active_tables do
    Table
    |> where(active: true)
    |> Repo.all()
    |> Repo.preload(:floor)
  end

  def list_inactive_tables do
    Table
    |> where(active: false)
    |> Repo.all()
    |> Repo.preload(:floor)
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
  def get_table!(id) do
    Table
    |> Repo.get!(id)
    |> Repo.preload(:floor)
  end

  def get_table(id) do
    Table
    |> Repo.get(id)
    |> Repo.preload(:floor)
  end

  @doc """
  Creates a table.

  ## Examples

      iex> create_table(%{field: value})
      {:ok, %Table{}}

      iex> create_table(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_table(%Floor{} = floor, attrs \\ %{}) do
    %Table{}
    |> Table.changeset(attrs)
    |> Ecto.Changeset.put_change(:floor_id, floor.id)
    |> Repo.insert()
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
