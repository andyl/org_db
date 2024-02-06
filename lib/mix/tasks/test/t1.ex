defmodule Mix.Tasks.Test.T1 do

  use Mix.Task

  alias OrgDb.Doc.Section

  def run(_) do
    OrgDb.TestData.set1()
    |> Section.ingest()
    |> IO.inspect()
  end
end
