defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """

  import Helper
  require IO
  require Enum

  def start(_type, _args) do
    input = read_input()
    
    IO.puts "pt1: "
    input 
    |> day1 
    |> inspect
    |> IO.puts
  
    IO.puts "pt2: "
    input 
    |> day1p2 
    |> inspect
    |> IO.puts

  end

  def day1(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&to_elf/1)
    |> Enum.map(&to_total/1)
    |> max
  end

  def day1p2(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&to_elf/1)
    |> Enum.map(&to_total/1)
    |> Enum.sort(:desc)
    |> sum_first_3
  end

  def sum_first_3( [a , b ,  c | _] ) do
    a + b + c 
  end

  def max( [head] ) do head end
  def max( [ head | tail ]) do
    mtail = max(tail)
    if mtail > head do
      mtail
    else
      head
    end
  end

  def to_elf(strelf) do
    strelf
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def to_total(elf) do
    elf 
    |> Enum.sum
  end
end
