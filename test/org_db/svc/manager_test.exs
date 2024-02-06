defmodule OrgDb.Svc.ManagerTest do

  use ExUnit.Case

  alias OrgDb.Svc.Manager
  alias OrgDb.Util.Test

  describe "#start_link/1" do
    test "using start_link directly" do
      assert {:ok, _pid} = Manager.start_link(base_dir: base_dir())
    end

    test "with start_supervised" do
      assert {:ok, _pid} = start_supervised({Manager, [base_dir: base_dir()]})
    end

    test "with start_supervised!" do
      assert start_supervised!({Manager, [base_dir: base_dir()]})
    end

    test "registered process name" do
      start_supervised({Manager, [base_dir: base_dir()]})
      assert Process.whereis(:svc_manager)
    end
  end

  describe "#insert/1" do
    test "using a file with one section" do
      start_supervised({Manager, [base_dir: base_dir()]})
      count1 = Manager.select_all() |> length()
      Manager.insert(Test.org_file())
      count2 = Manager.select_all() |> length()
      assert count2 == count1 + 1
    end

    test "using a file with three sections" do
      start_supervised({Manager, [base_dir: base_dir()]})
      count1 = Manager.select_all() |> length()
      Manager.insert(Test.test_file())
      count2 = Manager.select_all() |> length()
      assert count2 == count1 + 3
    end
  end

  describe "#delete/1" do
    test "using a file with three sections" do
      start_supervised({Manager, [base_dir: Test.test_dir()]})
      count1 = Manager.select_all() |> length()
      Manager.delete(Test.test_file())
      count2 = Manager.select_all() |> length()
      assert count2 == count1 - 3
    end
  end

  describe "#upsert/1" do
    test "using a file with three sections" do
      start_supervised({Manager, [base_dir: Test.test_dir()]})
      count1 = Manager.select_all() |> length()
      Manager.upsert(Test.test_file())
      count2 = Manager.select_all() |> length()
      assert count2 == count1
    end
  end

  # ----- helpers

  def base_dir do
    Test.test_dir()
  end

end
