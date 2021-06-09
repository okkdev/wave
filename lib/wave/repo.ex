defmodule Wave.Repo do
  use Ecto.Repo,
    otp_app: :wave,
    adapter: Ecto.Adapters.Postgres
end
