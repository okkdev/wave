# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :wave,
  ecto_repos: [Wave.Repo]

# Configures the endpoint
config :wave, WaveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "f8GGNJl4YBGhlzgk3N3ZwD5DgehZgKCt2kjpbhGK87ywdTru6GWG9euFotBNTkfR",
  render_errors: [view: WaveWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Wave.PubSub,
  live_view: [signing_salt: "hmhsZHh7"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Timezone config
config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
