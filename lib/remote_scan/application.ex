defmodule RemoteScan.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      %{
        id: RemoteScan.Listener,
        start: {RemoteScan.Listener, :start_link, [5001, RemoteScan]},
        restart: :permanent
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RemoteScan.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
