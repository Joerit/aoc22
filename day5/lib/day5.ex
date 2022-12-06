defmodule Day5 do
  
  import Helper
  import String, only: [to_integer: 1]

  require Stream
  require Enum
  require Tuple



  def start(_, _) do
    
    "#######test:" |> IO.puts        
    read_input("./testinput")
    |> day5pt1
    
    "#######input: " |> IO.puts        
    read_input("./input")
    |> day5pt1
    
    "#######test:" |> IO.puts        
    read_input("./testinput")
    |> day5pt2

    "#######input: " |> IO.puts        
    read_input("./input")
    |> day5pt2
  end

  def day5pt1(input) do
    day5(input, false)
  end
  def day5pt2(input) do
    day5(input, true)
  end

  def day5(input, rev) do
    [state, commands] = String.split(input, "\n\n")

    "fields: " |> IO.puts      
    fields = state |> to_field |> list_to_map |> IO.inspect

    "commands: " |> IO.puts
    commands
    |> String.trim
    |> parse_all_commands
    |> IO.inspect
    |> Enum.reverse
    |> do_commands(fields, rev)
    |> IO.inspect
    |> Map.values
    |> IO.inspect
    |> get_tops
    |> inspect
    |> IO.puts
  end

  def to_field(stateinput) do
    stateinput
    |> String.split("\n")
    |> Enum.reverse
    |> strip_first
    |> Enum.reverse
    |> input_to_stacks
  end

  def list_to_map(list) do
    {_, ret} = list
               |> Enum.reverse
               |> _list_to_map
    ret
  end
  def _list_to_map([head]) do
    {2, %{1 => head }}
  end
  def _list_to_map([head | tail]) do
    {index, map} = _list_to_map(tail)
    {(index+1), (Map.update(map, index, head, fn _-> end))}
  end

  def strip_first([_head | tail]), do: tail 

  def input_to_stacks(input) do
    input
    |> Enum.map(fn x -> 
      String.graphemes(x) |> Enum.chunk_every(3, 4) 
    end)
    |> Enum.zip
    |> Enum.map(fn x -> Tuple.to_list(x) |> list_to_stack end)
    |> Enum.to_list
  end

  def list_to_stack([head]) do 
    [_, headchar, _] = head
    [headchar]
  end

  def list_to_stack([head | tail]) do
    [_, headchar, _] = head
    if headchar == " "  do
      list_to_stack(tail)
    else
      [headchar | list_to_stack(tail)]
    end
  end

  def parse_all_commands(str) do
    String.split(str, "\n")
    |> IO.inspect
    |> Enum.map(&parse_command/1)
  end

  def parse_command(line) do
    [_, amount, _, from, _, to] = String.split(line, " ")
    {to_integer(amount), to_integer(from), to_integer(to)} 
  end
  
  def do_commands(comlist, state, rev \\ false)
  def do_commands([command], state, rev) do
    {amount, from, to} = command
    res = pop(state[from], amount)
    newfromlist = elem(res, 1)
    
    popped = if rev do Enum.reverse(elem(res, 0)) else elem(res, 0) end
    
    newtolist = push(state[to], popped)
    state 
    |> Map.replace!(from, newfromlist)
    |> Map.replace!(to, newtolist)
  end
  def do_commands([command | tail], state, rev) do
    do_commands([command], do_commands(tail, state, rev), rev)
  end

  def pop([head | tail], 1) do
    {[head], tail}
  end
  def pop([head | tail], amount) do
    {popped, newlist} = pop(tail, amount-1)
    {[head | popped], newlist}
  end

  def push(list, [head]) do
    [head | list]
  end
  def push(list, [head | tail]) do
    push(push(list, [head]), tail)
  end

  def get_tops(list) do
    list 
    |> Enum.each(fn stack -> IO.puts(List.first(stack))end)
  end
end
