defmodule Mix.Tasks.Test.T5 do
  use Mix.Task

  def run(_) do
    "/home/aleak/util/org"
    |> OrgDb.Doc.Dir.ingest()
    |> List.flatten()
    |> length()
    |> IO.inspect()
  end
end
