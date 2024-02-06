defmodule Mix.Tasks.Test.T3 do
  use Mix.Task

  def run(_) do
    base_path()
    |> OrgDb.Doc.Dir.ingest()
    |> IO.inspect()
  end

  def base_path do
    root_dir =
      __ENV__.file
      |> String.split("/lib")
      |> hd()

    root_dir <> "/data"
  end
end
