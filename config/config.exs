# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :manawave, ManawaveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5Ga46tgwI2NJrk82+aU5jvqMrerIttB21ruR/I+mBN6oys1T5dyOeKWlvrFqDEBt",
  render_errors: [view: ManawaveWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Manawave.PubSub,
  live_view: [signing_salt: "klTnqVEP"]

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
