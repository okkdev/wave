defmodule WaveWeb.Router do
  use WaveWeb, :router
  import Plug.BasicAuth
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {WaveWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug :basic_auth,
      username: "admin",
      password: Application.fetch_env(:wave, :dashboard_password)
  end

  pipeline :traced do
    plug WaveWeb.Plugs.Trace
  end

  scope "/", WaveWeb do
    pipe_through :browser

    get "/tracing", ContactController, :index
    post "/tracing", ContactController, :create
  end

  scope "/dashboard", WaveWeb do
    pipe_through [:browser, :protected]

    live "/", DashboardLive
    live "/settings", DashboardSettingsLive
    live "/tracing", DashboardTracingLive
    live_dashboard "/app", metrics: WaveWeb.Telemetry, ecto_repos: [Wave.Repo]
  end

  scope "/", WaveWeb do
    pipe_through [:browser, :traced]

    live "/", PageLive, :index
    live "/table/:table_id", WaveLive
  end
end
