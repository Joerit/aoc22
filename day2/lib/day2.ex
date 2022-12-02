defmodule Day2 do
  @moduledoc """
  Documentation for `Day2`.
  """

  import Helper
  require Stream
  require Enum

  def start(_, _) do

    read_test()
    |> day2p1()

    read_lines()
    |> day2p1()

    read_test()
    |> day2p2()

    read_lines()
    |> day2p2()

  end

  def day2p1(list) do
    list |> day2(&to_points_p1/1)
  end

  def day2p2(list) do
    list |> day2(&to_points_p2/1)
  end

  def day2(list, to_scores) do
    list
    |> Stream.map(to_scores)
    |> IO.inspect
    |> Enum.sum
    |> inspect
    |> IO.puts
  end

  @doc """
  A rock
  B paper
  C scissors

  X rock
  Y paper
  Z scissors
  """
  def to_points_p1(str) do
    [them, _, me | _] = 
      str
      |> String.graphemes
    
    case {them, me} do
      {"A", "X"} -> 4
      {"A", "Y"} -> 8
      {"A", "Z"} -> 3
      {"B", "X"} -> 1
      {"B", "Y"} -> 5
      {"B", "Z"} -> 9
      {"C", "X"} -> 7
      {"C", "Y"} -> 2
      {"C", "Z"} -> 6
      _ -> 0 # last is empty, 0 has no impact
    end
  end
  
  def to_points_p2(str) do
    [them, _, me | _] = 
      str
      |> String.graphemes
    
    game = {them, me}
    case game do
      {"A", "X"} -> 3
      {"A", "Y"} -> 4
      {"A", "Z"} -> 8
      {"B", "X"} -> 1
      {"B", "Y"} -> 5
      {"B", "Z"} -> 9
      {"C", "X"} -> 2
      {"C", "Y"} -> 6
      {"C", "Z"} -> 7
      _ -> 0 # last is empty, 0 has no impact
    end
  end




end
