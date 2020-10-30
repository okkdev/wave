defmodule Wave.WavesTest do
  use Wave.DataCase

  alias Wave.Waves

  describe "floors" do
    alias Wave.Waves.Floor

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def floor_fixture(attrs \\ %{}) do
      {:ok, floor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Waves.create_floor()

      floor
    end

    test "list_floors/0 returns all floors" do
      floor = floor_fixture()
      assert Waves.list_floors() == [floor]
    end

    test "get_floor!/1 returns the floor with given id" do
      floor = floor_fixture()
      assert Waves.get_floor!(floor.id) == floor
    end

    test "create_floor/1 with valid data creates a floor" do
      assert {:ok, %Floor{} = floor} = Waves.create_floor(@valid_attrs)
      assert floor.name == "some name"
    end

    test "create_floor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Waves.create_floor(@invalid_attrs)
    end

    test "update_floor/2 with valid data updates the floor" do
      floor = floor_fixture()
      assert {:ok, %Floor{} = floor} = Waves.update_floor(floor, @update_attrs)
      assert floor.name == "some updated name"
    end

    test "update_floor/2 with invalid data returns error changeset" do
      floor = floor_fixture()
      assert {:error, %Ecto.Changeset{}} = Waves.update_floor(floor, @invalid_attrs)
      assert floor == Waves.get_floor!(floor.id)
    end

    test "delete_floor/1 deletes the floor" do
      floor = floor_fixture()
      assert {:ok, %Floor{}} = Waves.delete_floor(floor)
      assert_raise Ecto.NoResultsError, fn -> Waves.get_floor!(floor.id) end
    end

    test "change_floor/1 returns a floor changeset" do
      floor = floor_fixture()
      assert %Ecto.Changeset{} = Waves.change_floor(floor)
    end
  end

  describe "tables" do
    alias Wave.Waves.Table

    @valid_attrs %{active: true, number: 42}
    @update_attrs %{active: false, number: 43}
    @invalid_attrs %{active: nil, number: nil}

    def table_fixture(attrs \\ %{}) do
      {:ok, table} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Waves.create_table()

      table
    end

    test "list_tables/0 returns all tables" do
      table = table_fixture()
      assert Waves.list_tables() == [table]
    end

    test "get_table!/1 returns the table with given id" do
      table = table_fixture()
      assert Waves.get_table!(table.id) == table
    end

    test "create_table/1 with valid data creates a table" do
      assert {:ok, %Table{} = table} = Waves.create_table(@valid_attrs)
      assert table.active == true
      assert table.number == 42
    end

    test "create_table/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Waves.create_table(@invalid_attrs)
    end

    test "update_table/2 with valid data updates the table" do
      table = table_fixture()
      assert {:ok, %Table{} = table} = Waves.update_table(table, @update_attrs)
      assert table.active == false
      assert table.number == 43
    end

    test "update_table/2 with invalid data returns error changeset" do
      table = table_fixture()
      assert {:error, %Ecto.Changeset{}} = Waves.update_table(table, @invalid_attrs)
      assert table == Waves.get_table!(table.id)
    end

    test "delete_table/1 deletes the table" do
      table = table_fixture()
      assert {:ok, %Table{}} = Waves.delete_table(table)
      assert_raise Ecto.NoResultsError, fn -> Waves.get_table!(table.id) end
    end

    test "change_table/1 returns a table changeset" do
      table = table_fixture()
      assert %Ecto.Changeset{} = Waves.change_table(table)
    end
  end
end
