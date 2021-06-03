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
      password: Application.get_env(:wave, :dashboard_password)
  end

  pipeline :traced do
    plug Wave.Plugs.Trace
  end

  scope "/", WaveWeb do
    pipe_through :browser

    live "/tracing", ContactLive
  end

  scope "/dashboard", WaveWeb do
    pipe_through [:browser, :protected]

    live "/", DashboardLive
    live_dashboard "/app", metrics: WaveWeb.Telemetry, ecto_repos: [Wave.Repo]
  end

  scope "/", WaveWeb do
    pipe_through [:browser, :traced]

    live "/", PageLive, :index
    live "/table/:floor/:number", WaveLive
  end
end
