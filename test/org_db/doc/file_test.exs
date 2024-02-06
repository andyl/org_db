defmodule OrgDb.Doc.FileTest do

  use ExUnit.Case

  alias OrgDb.Doc.File
  alias OrgDb.Doc.Section
  alias OrgDb.Util.Test

  describe "#ingest/2" do
    test "from test file" do
      output = Test.test_file() |> File.ingest()
      assert output |> is_list()
      assert output |> length() == 3
    end

    test "data elements" do
      output = Test.test_file() |> File.ingest()
      head = output |> List.first()
      assert %Section{} = head
      assert head.doctitle != ""
      assert head.filepath != ""
      assert head.startline == 1
    end
  end

end
