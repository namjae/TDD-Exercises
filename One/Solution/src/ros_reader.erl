-module(ros_reader).
-export([read_file/1,
	 read_dir/1
	]).

-spec(read_file(string()) -> {ok,term()} | {error,no_such_file}).
read_file(File) ->
    case file:read_file(File) of
	{error,enoent} ->
	    {error,no_such_file};
	R -> R
    end.

-spec(read_dir(string()) -> {ok,[{string(),term()}]} | {error,no_such_dir}).
read_dir(Dir) ->
    case file:list_dir(Dir) of
	{ok,Files} ->
	    Res = [{File, read_file(filename:join(Dir,File))} || File <- Files ],	    
	    {ok,lists:sort(Res)};
	{error,enoent} ->
	    {error,no_such_dir}
    end.

