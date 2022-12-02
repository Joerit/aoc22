defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "greets the world" do
    assert Day2.to_score({"A", "X"}) == 1
  end
end
