defmodule Helper do
  @moduledoc """
  Some helper functions for aoc
  """
  def read_lines() do
    read_input()
    |> String.split("\n")
  end

  def read_input() do
    File.read!("./input")
  end
end
