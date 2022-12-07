defmodule Helper do
  @moduledoc """
  Some helper functions for aoc
  """
  def run(pt1, pt2) do
    "PT1: " |> IO.puts 
    "# test:" |> IO.puts
    read_input("./testinput")
    |> pt1.()

    "# input:" |> IO.puts
    read_input("./input")
    |> pt1.()
    
    "PT2: " |> IO.puts 
    "# test:" |> IO.puts
    read_input("./testinput")
    |> pt2.()

    "# input:" |> IO.puts
    read_input("./input")
    |> pt2.()
  end

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
  
  def list_to_map(list, start \\ 0) do
    {_, ret} = list
               |> Enum.reverse
               |> _list_to_map(start)
    ret
  end
  def _list_to_map(list, start \\ 0)
  def _list_to_map([head], start) do
    { start+1, %{start => head }}
  end
  def _list_to_map([ head | tail ], start) do
    { index, map } = _list_to_map(tail, start)
    {( index+1 ), (Map.update( map, index, head, fn x -> x end ))}
  end

  def pop([head | tail]) do
    {[ head ], tail}
  end
end
