defmodule Mix.Tasks.Test.T6 do
  use Mix.Task

  alias OrgDb.Doc.Dir
  alias OrgDb.Fts.Db

  def run(_) do
    data =
      "/home/aleak/util/org"
      |> Dir.ingest()
      |> List.flatten()

    db = Db.open()
    Db.load(db, data)

    Db.search(db, "Reflow")
    |> IO.inspect()
  end
end
