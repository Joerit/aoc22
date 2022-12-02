defmodule Helper do
  @moduledoc """
  Some helper functions for aoc
  """
  def read_lines() do
    read_input("./input")
    |> String.split("\n", trim: true)
  end

  def read_test() do
    read_input("./testinput")
    |> String.split("\n", trim: true)
  end

  def read_input(file \\ "./input") do
    File.read!(file)
  end



end
