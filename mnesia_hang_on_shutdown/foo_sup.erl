-module(foo_sup).

-behaviour(supervisor).

% The public interface
-export([start_link/1, init/1]).

% The maximum number of times we're willing to restart the processes
-define(MAX_RESTART,    5).

% How long to wait for the start up
-define(MAX_TIME,      60).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Public interface
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%% @doc Kicks off the supervisor process.
%% @spec (Args::[]) -> {ok, Pid} | ignore | {error, Error}
%%
start_link([]) ->
     supervisor:start_link({local,?MODULE}, ?MODULE, []).


init(Args) ->
    process_flag(trap_exit, true),
    {ok, { %supervisor policy
           {one_for_all, ?MAX_RESTART, ?MAX_TIME},
           [
               {foo_supervisor_id,
                  {foo_main,start_link,[Args]},
                  permanent,
                  30000,
                  worker,
                  [woc_man_main]
              }
           ]
         }  
    }.
