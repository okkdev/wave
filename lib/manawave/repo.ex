defmodule Manawave.Repo do
  use Ecto.Repo,
    otp_app: :manawave,
    adapter: Ecto.Adapters.Postgres
end
