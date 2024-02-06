defmodule OrgDb.Doc.Svc.DocStage do

  # use GenStage
  #
  # @moduledoc """
  # DocStage for ingesting documents - a GenStage producer.
  # """
  #
  # @procname :doc_stage
  #
  # alias OrgDb.Util.File
  # alias OrgDb.Util.Queue
  #
  # import OrgDb.Util.Xmap
  #
  # # ----- startup
  #
  # @doc """
  # Start the DocStage server
  # """
  # def start_link(options \\ []) when is_list(options) do
  #   GenStage.start_link(__MODULE__, options, name: @procname)
  # end
  #
  # @doc false
  # @impl true
  # def init(options) do
  #   {:producer, init_state(options)}
  # end
  #
  # # ----- api
  #
  # def base_dir do
  #   GenStage.call(@procname, :ds_base_dir)
  # end
  #
  # def collection_name do
  #   base_dir()
  #   |> Path.basename()
  # end
  #
  # def doc_list do
  #   base_dir() |> File.markdown_files()
  # end
  #
  # def event_queue do
  #   GenStage.call(@procname, :ds_event_queue)
  # end
  #
  # def state do
  #   GenStage.call(@procname, :ds_state)
  # end
  #
  # def upsert_file(path) do
  #   GenStage.cast(@procname, {:ds_upsert, path})
  # end
  #
  # def delete_file(path) do
  #   GenStage.cast(@procname, {:ds_delete, path})
  # end
  #
  # # ----- callbacks
  #
  # @impl true
  # def handle_call(:ds_base_dir, _from, state) do
  #   {:reply, state.base_dir, [], state}
  # end
  #
  # @impl true
  # def handle_call(:ds_event_queue, _from, state) do
  #   {:reply, state.event_queue, [], state}
  # end
  #
  # @impl true
  # def handle_call(:ds_state, _from, state) do
  #   {:reply, state, [], state}
  # end
  #
  # @impl true
  # def handle_cast({:ds_upsert, path}, state) do
  #   queue = append_queue(state.event_queue, :upsert, path)
  #   {:noreply, [], assign(state, :event_queue, queue)}
  # end
  #
  # @impl true
  # def handle_cast({:ds_delete, path}, state) do
  #   queue = append_queue(state.event_queue, :delete, path)
  #   {:noreply, [], assign(state, :event_queue, queue)}
  # end
  #
  # @impl true
  # def handle_demand(demand_count, state) do
  #   {events, new_queue} = Queue.pop(state.event_queue, demand_count)
  #   {:noreply, events, assign(state, :event_queue, new_queue)}
  # end
  #
  # # ----- helpers
  #
  # def default_state do
  #   %{
  #     base_dir: "/home/aleak/util/org",
  #     event_queue: Queue.new(),
  #   }
  # end
  #
  # def init_state(options) do
  #   state = default_state() |> Map.merge(Enum.into(options, %{}))
  #   queue = state.base_dir |> File.markdown_events() |> Queue.from_list()
  #   state |> assign(:event_queue, queue)
  # end
  #
  # defp append_queue(queue, action, path) do
  #   event = {action, path, File.mtime(path)}
  #
  #   queue
  #   |> Queue.filter(fn {_action, lpath, _mtime} -> path != lpath end)
  #   |> Queue.push(event)
  # end

end
