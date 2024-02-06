defmodule OrgDb.Svc.Httpd.Router do
  @moduledoc false

  use Plug.Router, init_mode: :runtime

  alias OrgDb.Svc.Manager

  require Logger

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, ":ok")
  end

  get "/all" do
    send_resp(conn, 200, gen_all())
  end

  # /search?query='my query'
  get "/search" do
    query = Plug.Conn.fetch_query_params(conn).query_params["query"]

    result = case query do
      nil -> "[]"
      _ -> gen_response(query)
    end

    send_resp(conn, 200, result)
  end

  match _ do
    Logger.error("File not found: #{conn.request_path}")

    send_resp(conn, 404, "NOT FOUND")
  end

  # defp delete_body(list) do
  #   delete_at(list, 1)
  # end

  # defp delete_at(list, index) do
  #   list
  #   |> Enum.with_index()
  #   |> Enum.reject(fn {_, idx} -> idx == index end)
  #   |> Enum.map(fn {elem, _} -> elem end)
  # end

  defp retain_at(list, index_list) when is_list(index_list) do
    list
    |> Enum.with_index()
    |> Enum.reject(fn {_, idx} -> idx not in index_list end)
    |> Enum.map(fn {elem, _} -> elem end)
  end

  defp gen_response(query) do
    clean_query =
      query
      |> String.replace("\"", "")
      |> String.replace("'", "")
      |> String.replace("\\", "")

    Manager.search(clean_query)
    # |> Enum.map(&delete_body(&1))
    |> Enum.map(&retain_at(&1, [0,4,7,8,9]))
    |> Jason.encode!()
  end

  defp gen_all do
    Manager.select_all()
    |> Enum.map(&retain_at(&1, [0,4,7,8,9]))
    |> Jason.encode!()
  end
end
