defmodule OrgDb.Doc.Svc.Supervisor do
  #
  # @moduledoc false
  #
  # use Supervisor
  #
  # @dir "/home/aleak/util/org"
  #
  # def start_link(init_arg) do
  #   Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  # end
  #
  # @impl true
  # def init(_init_arg) do
  #   if Application.get_env(:md_tools, :fts_server) do
  #     children = [
  #       {OrgDb.Doc.Svc.Watcher, [base_dir: @dir]},
  #       {OrgDb.Doc.Svc.DocStage, [base_dir: @dir]}
  #     ]
  #
  #     Supervisor.init(children, strategy: :one_for_one)
  #   else
  #     :ignore
  #   end
  # end

end
