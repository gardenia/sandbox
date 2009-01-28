-module(foo_main).
-behaviour(gen_server).

%% External exports
-export([
    start_link/1
]).

%% gen-server callbacks
-export([
    init/1, handle_call/3, handle_cast/2,
    handle_info/2, terminate/2, code_change/3
]).

-record(state, {}).

start_link(_Args) ->
    error_logger:info_msg("foo_main:start_link ..."),
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    error_logger:info_msg("foo_main:init ..."),
    process_flag(trap_exit, true),

    error_logger:info_msg("starting mnesia..."),
    application:start(mnesia),
    error_logger:info_msg("started mnesia "),

    {ok, #state{}}.

handle_call(_Message, _From, State) ->
    {noreply, State}.
handle_cast(_Request, State) ->
    {noreply, State}.
handle_info(_Info, State) ->
    {noreply, State}.
code_change(_OldVersion, State, _Extra) ->
    {ok, State}.

terminate(Reason, _State) ->
    error_logger:info_msg("foo_main:terminate with [~p]", [Reason]),
    error_logger:info_msg("Stopping mnesia ...."),
    application:stop(mnesia),
    error_logger:info_msg("Stopped mnesia"),
    ok.

