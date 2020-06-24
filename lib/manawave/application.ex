defmodule Manawave.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ManawaveWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Manawave.PubSub},
      # Start the Endpoint (http/https)
      ManawaveWeb.Endpoint
      # Start a worker by calling: Manawave.Worker.start_link(arg)
      # {Manawave.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Manawave.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ManawaveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
