-module(foo).

-behaviour(application).

-export([start/2, stop/1]).

start(_Type, StartArgs) ->
    error_logger:info_msg("foo:start ..."),
    foo_sup:start_link(StartArgs).

stop(_State) ->
    error_logger:info_msg("foo:stop ..."),
    ok.
