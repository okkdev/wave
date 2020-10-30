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

Waves.create_floor(%{name:"OG"})
Waves.create_floor(%{name:"EG"})
Waves.create_floor(%{name:"UG"})
Waves.create_floor(%{name:"AT"})
