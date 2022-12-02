defmodule HelperTest do
  use ExUnit.Case
  doctest Helper

  test "read_input" do
    assert Helper.read_input() == "a\nb\nc\n"
  end

  test "read_lines" do
    assert Helper.read_lines() == ["a", "b", "c", ""]
  end

end
