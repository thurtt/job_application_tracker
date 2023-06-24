defmodule ApplicationTracker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ApplicationTrackerWeb.Telemetry,
      # Start the Ecto repository
      ApplicationTracker.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ApplicationTracker.PubSub},
      # Start Finch
      {Finch, name: ApplicationTracker.Finch},
      # Start the Endpoint (http/https)
      ApplicationTrackerWeb.Endpoint
      # Start a worker by calling: ApplicationTracker.Worker.start_link(arg)
      # {ApplicationTracker.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ApplicationTracker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ApplicationTrackerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
