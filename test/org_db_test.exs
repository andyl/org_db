defmodule OrgDbTest do
  use ExUnit.Case
  doctest OrgDb

  test "greets the world" do
    assert OrgDb.hello() == :world
  end
end
