defmodule OrgDb.Fts.DbTest do
  use ExUnit.Case

  alias OrgDb.Fts.Db
  alias OrgDb.Doc.Section

  describe "#open/0" do
    test "an in-memory database" do
      conn = Db.open()
      assert conn
    end

    test "an on-file database" do
      dbpath = "/home/aleak/killme.db"
      File.rm_rf(dbpath)
      conn = Db.open(dbpath)
      assert conn
    end
  end

  describe "#load_row/2" do
    test "one single row" do
      dbpath = "/home/aleak/killme.db"
      File.rm_rf(dbpath)
      conn = Db.open(dbpath)
      result = Db.load_row(conn, %Section{}) |> Db.select_all()
      assert result
      assert length(result) == 1
    end

    test "two row" do
      dbpath = "/home/aleak/killme.db"
      File.rm_rf(dbpath)
      conn = Db.open(dbpath)
      Db.load_row(conn, %Section{doctitle: "ONE"})
      Db.load_row(conn, %Section{doctitle: "TWO"})
      result = Db.select_all(conn)
      assert result
      assert length(result) == 2
    end
  end

  describe "#load_file/2" do
    test "with test data" do
      dbpath = "/home/aleak/killme.db"
      File.rm_rf(dbpath)
      conn = Db.open(dbpath)
      Db.load_file(conn, OrgDb.Util.Test.test_file())
      result = Db.select_all(conn)
      assert result
      assert length(result) == 3
    end
  end

  describe "#select_all/1" do
    test "with zero records" do
      result =
        Db.open()
        |> Db.select_all()

      assert is_list(result)
      assert length(result) == 0
    end

    test "with three records" do
      dbpath = "/home/aleak/killme.db"
      File.rm_rf(dbpath)
      conn = Db.open(dbpath)
      Db.load_row(conn, %Section{doctitle: "ONE", body: "TICK bing"})
      Db.load_row(conn, %Section{doctitle: "TWO", body: "TOCK bong "})
      Db.load_row(conn, %Section{doctitle: "THREE", body: "TICK pong"})
      result = Db.select_all(conn)
      assert length(result) == 3
    end
  end

  describe "#search/2" do
    test "basic search" do
      dbpath = "/home/aleak/killme.db"
      File.rm_rf(dbpath)
      conn = Db.open(dbpath)
      Db.load_row(conn, %Section{doctitle: "ONE", body: "TICK bing"})
      Db.load_row(conn, %Section{doctitle: "TWO", body: "TOCK bong "})
      Db.load_row(conn, %Section{doctitle: "THREE", body: "TICK pong"})
      result = Db.search(conn, "pong")
      assert result
    end
  end

  describe "#empty/1" do
    test "erases all records" do
      dbpath = "/home/aleak/killme.db"
      File.rm_rf(dbpath)
      conn = Db.open(dbpath)
      Db.load_row(conn, %Section{doctitle: "ONE", body: "TICK bing"})
      Db.load_row(conn, %Section{doctitle: "TWO", body: "TOCK bong "})
      Db.load_row(conn, %Section{doctitle: "THREE", body: "TICK pong"})
      result1 = Db.empty(conn)
      assert result1
      result2 = Db.select_all(conn)
      assert result2 == []
    end
  end

end
