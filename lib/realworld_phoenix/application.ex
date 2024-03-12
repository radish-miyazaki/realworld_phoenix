defmodule RealworldPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RealworldPhoenixWeb.Telemetry,
      RealworldPhoenix.Repo,
      {DNSCluster, query: Application.get_env(:realworld_phoenix, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: RealworldPhoenix.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: RealworldPhoenix.Finch},
      # Start a worker by calling: RealworldPhoenix.Worker.start_link(arg)
      # {RealworldPhoenix.Worker, arg},
      # Start to serve requests, typically the last entry
      RealworldPhoenixWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RealworldPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RealworldPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
