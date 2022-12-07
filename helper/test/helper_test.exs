defmodule HelperTest do
  use ExUnit.Case
  doctest Helper

  test "read_input" do
    assert Helper.read_input() == "a\nb\nc\n"
  end

  test "read_lines" do
    assert Helper.read_lines() == ["a", "b", "c"]
  end

  test "list_to_map" do
    assert Helper.list_to_map([1, 2, 3, 4]) ==
      %{0 => 1, 1 => 2, 2 => 3, 3 => 4}
    assert Helper.list_to_map([1, 2, 3, 4], 2) ==
      %{2 => 1, 3 => 2, 4 => 3, 5 => 4}
  end

end
