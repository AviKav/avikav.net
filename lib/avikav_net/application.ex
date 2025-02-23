defmodule AvikavNet.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AvikavNetWeb.Telemetry,
      AvikavNet.Repo,
      {Ecto.Migrator,
        repos: Application.fetch_env!(:avikav_net, :ecto_repos),
        skip: skip_migrations?()},
      {DNSCluster, query: Application.get_env(:avikav_net, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AvikavNet.PubSub},
      # Start a worker by calling: AvikavNet.Worker.start_link(arg)
      # {AvikavNet.Worker, arg},
      # Start to serve requests, typically the last entry
      AvikavNetWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AvikavNet.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AvikavNetWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    # By default, sqlite migrations are run when using a release
    System.get_env("RELEASE_NAME") != nil
  end
end
