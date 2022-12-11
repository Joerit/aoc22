defmodule Dir do
  @enforce_keys [:name, :files, :dirs, :size]
  defstruct [:name, :files, :dirs, :size]
end

defmodule Day7 do
  import Helper

  require Stream
  require Enum

  @total_size 70000000
  @required_size 30000000
  # 70M - 30M
  @max_size 40000000

  def start(_, _) do
    run(&pt1/1, &pt2/1)
  end

  def pt1(input) do
    input 
    |> parse_to_dir_tree
    |> sum_small_dirs
    |> IO.inspect
  end
  def pt2(input) do
    dir = input
          |> parse_to_dir_tree
    
    dir
    |> find_smallest_larger_than(dir.size - @max_size)
    |> IO.inspect
  end

  def parse_to_dir_tree(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> remove_ls_dir
    |> to_dir
    |> elem(0)
    |> List.first
  end

  def remove_ls_dir(lines) do
    lines
    |> Enum.reject(fn x -> is_ls?(x) or is_dir?(x) end)
  end
  def is_ls?("$ ls") do
    true
  end
  def is_ls?(_) do
    false
  end
  def is_dir?("dir"<>_) do
    true
  end
  def is_dir?(_) do
    false
  end


  # folder is structured:
  # - files
  # - folders
  #
  # so, tofiles can return list of files, then call todirs, stop at "$ cd .."
  #

  # lines are either: "12345 filename" or "$ cd filename"
  def to_files([]) do
    "done" |> IO.puts
    {[], []}
  end
  def to_files(["$"<>next | ftail]) do
    {[], ["$"<>next | ftail]}
  end
  def to_files([next | ftail]) do
    file = next 
           |> line_to_file
    {flist, remainder} = ftail 
                         |> to_files
    {[file | flist] , remainder}
  end

  def line_to_file(line) do
    [size, name] = line
            |> String.split(" ")
    {String.to_integer(size), name}
  end

  @spec to_dir([String.t]) :: {Dir, [String.t]}
  def to_dir([]) do "done" |> IO.puts
    {[], []}
  end
  def to_dir(["$ cd .." | tail]) do
    {[], tail}
  end
  def to_dir(["$ cd "<>name | tail]) do
    # parse files in dir
    {flist, ftail} = tail |> to_files
    fsize = flist |> files_to_size
    # parse dirs in dir
    {dnest, dntail} = ftail |> to_dir
    dsize = dnest |> dirs_to_size
    # perse neighbour dirs
    {dlist, dtail} = dntail |> to_dir
    
    {[%Dir{name: name, files: flist, dirs: dnest, size: fsize + dsize} | dlist], dtail}
  end

  def files_to_size(flist) do
    flist 
    |> Enum.reduce(0, fn f, acc -> elem(f, 0) + acc end)
  end

  def dirs_to_size(dlist) do
    dlist
    |> Enum.reduce(0, fn d, acc -> d.size + acc end)
  end

  def sum_small_dirs(dir) do
    subsize = dir.dirs
              |> Enum.reduce(0, fn dir, acc -> sum_small_dirs(dir) + acc end)
    if dir.size < 100000 do
      subsize + dir.size
    else 
      subsize 
    end
  end
  def find_smallest_larger_than(dir, size) do
    min_sub = dir.dirs 
              |> Enum.map(fn d -> find_smallest_larger_than(d, size) end)
              |> Enum.min(fn -> @total_size end)
    
    if dir.size > size do
      min(dir.size, min_sub)
    else 
      min_sub
    end
  end
end
