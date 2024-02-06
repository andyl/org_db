defmodule OrgDb.Application do

  @moduledoc false

  @procname :orgdb_app

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      OrgDb.Svc.Supervisor
    ]

    opts = [strategy: :one_for_one, name: @procname]
    Supervisor.start_link(children, opts)
  end
end
