defmodule Day3 do
  import Helper
  require Stream
  require Enum

  import String, only: [slice: 2]

  # can't figure out how to do copdepoint math for the life of me
  # nvm disregasrd that, figured it out
  # @category_value %{
  #  'a' => 1, 'b' => 2, 'c' => 3, 'd' => 4, 'e' => 5, 
  #  'f' => 6, 'g' => 7, 'h' => 8, 'i' => 9, 'j' => 10, 
  #  'k' => 11, 'l' => 12, 'm' => 13, 'n' => 14, 'o' => 15, 
  #  'p' => 16, 'q' => 17, 'r' => 18, 's' => 19, 't' => 20, 
  #  'u' => 21, 'v' => 22, 'w' => 23, 'x' => 24, 'y' => 25,
  #  'z' => 26, 'A' => 27, 'B' => 28, 'C' => 29, 'D' => 30, 
  #  'E' => 31, 'F' => 32, 'G' => 33, 'H' => 34, 'I' => 35, 
  #  'J' => 36, 'K' => 37, 'L' => 38, 'M' => 39, 'N' => 40, 
  #  'O' => 41, 'P' => 42, 'Q' => 43, 'R' => 44, 'S' => 45, 
  #  'T' => 46, 'U' => 47, 'V' => 48, 'W' => 49, 'X' => 50, 
  #  'Y' => 51, 'Z' => 52, 
  #}
  def start(_, _) do

    read_test()
    |> day3()

    read_lines()
    |> day3()
  end

  def day3(input) do
    input
    |> IO.inspect
    |> Stream.map(&to_charlist/1)
    |> Stream.chunk_every(3)
    |> IO.inspect
    |> Stream.map(&sacks_to_duplicates/1)
    |> Enum.sum
    |> inspect
    |> IO.puts

  end

  def sacks_to_duplicates([comp1, comp2, comp3]) do
    comp1
    |> Enum.filter(fn(item) -> Enum.member?(comp2, item) end)   
    |> Enum.find(fn(item) -> Enum.member?(comp3, item) end)   
    |> to_prio_value
    |> IO.inspect
  end

  def to_prio_value(char) when char > ?`, do: (char - ?`) 

  def to_prio_value(char) when char < ?`, do: (char - ?` + 58)
end
