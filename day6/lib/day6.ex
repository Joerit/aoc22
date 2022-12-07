defmodule Day6 do
  import Helper

  require Stream
  require Enum
  require Tuple

  def start(_, _) do
    run(&pt1/1, &pt2/1)
  end

  def pt1(input) do
    day6(input, 4)
  end
  def pt2(input) do
    day6(input, 14)
  end

  def day6(input, len) do
    init = input |> String.at(0)
    initacc = {List.duplicate(init, len), 1}
    input
    |> String.graphemes
    |> Enum.reduce(initacc, &traverse_to_find/2)
    |> IO.inspect
  end

  # when done, skip ahead
  def traverse_to_find(next, {prevlist, index}) when index < 0 do
    {[], index}
  end
  def traverse_to_find(next, {prevlist, index}) do
    [_ | prevtail] = prevlist
    newlist = prevtail ++ [next]
    if is_unique?(newlist) do
      inspect(newlist) <> "is unique" |> IO.puts
      {[], -index}
    else
      {newlist, index+1}
    end
  end

  def is_unique?([head]) do true end
  def is_unique?([head | tail]) do
    is_unique?(tail) and !Enum.find(tail, false, fn x -> head == x end)
  end
end
