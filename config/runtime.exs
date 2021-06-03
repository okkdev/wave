import Config

config :wave,
  dashboard_password: System.get_env("DASHBOARD_PASSWORD", "admin")
