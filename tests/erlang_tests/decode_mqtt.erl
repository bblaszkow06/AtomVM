-module(decode_mqtt).

-export([start/0, parse/1, publish/2, g/1]).

start() ->
    Bin = publish(g("foo/bar"), g("This is a message.")),
    sum(g(parse(Bin))).

parse(<<16#20, MsgLen, 0, ReturnCode>>) ->
    {connack, MsgLen, ReturnCode};

parse(<<16#90, MsgLen, MsgId:16/integer-unsigned-big, QoS>>) ->
    {suback, MsgLen, MsgId, QoS};

parse(<<16#30, _MsgLen, TopicLen:16/integer-unsigned-big, TopicAndMsg/binary>>) ->
    <<Topic:TopicLen/binary, Msg/binary>> = TopicAndMsg,
    {publish, Topic, Msg};

parse(Binary) ->
    Binary.

publish(Topic, Message) ->
    TopicLen = byte_size(Topic),
    MsgLen = 2 + TopicLen + byte_size(Message),
    <<16#30, MsgLen, TopicLen:16/integer-unsigned-big, Topic/binary, Message/binary>>.

g(X) when is_list(X) ->
    erlang:list_to_binary(X);
g(X) when is_binary(X) ->
    erlang:binary_to_list(X);
g(X) ->
    X.

sum({publish, A, B}) ->
    W = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83,
         89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149],
    sum_list_w(0, g(A) ++ ":::" ++ g(B), W);
sum(_Tuple) ->
    0.

sum_list_w(Acc, [Head | Tail], [WHead | WTail]) ->
    sum_list_w(Acc + Head * WHead, Tail, WTail);

sum_list_w(Acc, [], _W) ->
    Acc.
