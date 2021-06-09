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

alias Wave.Repo
alias Wave.Waves.{Table, Floor}

# ManaBar Tables
floor_tables = [
  %Floor{
    name: "EG",
    tables: [
      %Table{number: 1},
      %Table{number: 2},
      %Table{number: 3},
      %Table{number: 4},
      %Table{number: 5},
      %Table{number: 6}
    ]
  },
  %Floor{
    name: "OG",
    tables: [
      %Table{number: 1},
      %Table{number: 2},
      %Table{number: 3},
      %Table{number: 4},
      %Table{number: 5},
      %Table{number: 6},
      %Table{number: 7}
    ]
  },
  %Floor{
    name: "UG",
    tables: [
      %Table{number: 1},
      %Table{number: 2}
    ]
  },
  %Floor{
    name: "AT",
    tables: [
      %Table{number: 1},
      %Table{number: 2}
    ]
  }
]

Enum.each(floor_tables, fn floor ->
  Repo.insert(floor)
end)
