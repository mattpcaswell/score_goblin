defmodule ScoreGoblin.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ScoreGoblinWeb.Telemetry,
      # Start the Ecto repository
      ScoreGoblin.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ScoreGoblin.PubSub},
      # Start Finch
      {Finch, name: ScoreGoblin.Finch},
      # Start the Endpoint (http/https)
      ScoreGoblinWeb.Endpoint
      # Start a worker by calling: ScoreGoblin.Worker.start_link(arg)
      # {ScoreGoblin.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ScoreGoblin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ScoreGoblinWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
