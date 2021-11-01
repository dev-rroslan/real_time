defmodule RealTime.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    topologies = Application.get_env(:libcluster, :topologies) || []

    children = [
      # Start the Ecto repository
      RealTime.Repo,
      # Start the Telemetry supervisor
      RealTimeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: RealTime.PubSub},
      # Start the Endpoint (http/https)
      RealTimeWeb.Endpoint,
      # Start a worker by calling: RealTime.Worker.start_link(arg)
      # {RealTime.Worker, arg}
      # setup for clustering
      {Cluster.Supervisor, [topologies, [name: RealTime.ClusterSupervisor]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RealTime.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RealTimeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
