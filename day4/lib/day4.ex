defmodule IDset do
  @enforce_keys [:start, :stop]
  defstruct [:start, :stop]
end

defmodule Day4 do
  
  import Helper
  require Stream
  require Enum


  def start(_, _) do
    read_test()
    |> day4()

    read_lines()
    |> day4()
  end

  def day4(input) do
    input
    |> Stream.map(&line_to_overlap/1)
    |> Enum.sum
    |> inspect
    |> IO.puts
  end

  def parse_range(str) do
    [start, stop] = String.split(str, "-")
    %IDset{ start: String.to_integer(start), stop: String.to_integer(stop)}
  end

  def line_to_overlap(line) do
    line 
    |> split_to_IDsets
    |> check_overlap
  end

  def split_to_IDsets(line) do
    String.split(line, ",")
    |> Enum.map(&parse_range/1)
  end

  def check_overlap([elf1, elf2]) do
    if (Range.disjoint?(elf1.start..elf1.stop, elf2.start..elf2.stop)) do
      0
    else
      1
    end
  end
end

