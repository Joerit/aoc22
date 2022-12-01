defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """

  import Helper
  require IO
  require Enum

  def start(_type, _args) do
    read_input()
    |> day1 
    |> inspect
    |> IO.puts
  end

  def day1(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&to_elf/1)
    |> Enum.map(&to_total/1)
    |> IO.inspect
    |> max
    |> IO.inspect
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
    |> IO.inspect
    |> Enum.map(&String.to_integer/1)
  end

  def to_total(elf) do
    elf 
    |> Enum.sum
  end










end
