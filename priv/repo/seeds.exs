# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Wave.Repo.insert!(%Wave.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Wave.Waves

# ManaBar Tables
tables = [EG: 6, OG: 7, UG: 2, AT: 2]

Enum.each(tables, fn {floor, tables} ->
  {:ok, floor} = Waves.create_floor(%{name: Atom.to_string(floor)})

  Waves.create_tables(floor.id, tables)
end)
