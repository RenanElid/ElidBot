defmodule ElidBot.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElidBot.Bot
    ]

    opts = [strategy: :one_for_one, name: ElidBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
