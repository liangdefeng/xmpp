%% Created automatically by XML generator (fxml_gen.erl)
%% Source: xmpp_codec.spec

-module(multi_last_item).

-compile(export_all).

do_decode(<<"item">>, <<"jabber:iq:multi:last">>, El,
	  Opts) ->
    decode_multi_last_item(<<"jabber:iq:multi:last">>, Opts,
			   El);
do_decode(Name, <<>>, _, _) ->
    erlang:error({xmpp_codec, {missing_tag_xmlns, Name}});
do_decode(Name, XMLNS, _, _) ->
    erlang:error({xmpp_codec, {unknown_tag, Name, XMLNS}}).

tags() -> [{<<"item">>, <<"jabber:iq:multi:last">>}].

do_encode({multi_last_item, _, _} = Item, TopXMLNS) ->
    encode_multi_last_item(Item, TopXMLNS).

do_get_name({multi_last_item, _, _}) -> <<"item">>.

do_get_ns({multi_last_item, _, _}) ->
    <<"jabber:iq:multi:last">>.

pp(multi_last_item, 2) -> [jid, seconds];
pp(_, _) -> no.

records() -> [{multi_last_item, 2}].

dec_int(Val, Min, Max) ->
    case erlang:binary_to_integer(Val) of
      Int when Int =< Max, Min == infinity -> Int;
      Int when Int =< Max, Int >= Min -> Int
    end.

enc_int(Int) -> erlang:integer_to_binary(Int).

decode_multi_last_item(__TopXMLNS, __Opts,
		       {xmlel, <<"item">>, _attrs, _els}) ->
    {Jid, Seconds} =
	decode_multi_last_item_attrs(__TopXMLNS, _attrs,
				     undefined, undefined),
    {multi_last_item, Jid, Seconds}.

decode_multi_last_item_attrs(__TopXMLNS,
			     [{<<"jid">>, _val} | _attrs], _Jid, Seconds) ->
    decode_multi_last_item_attrs(__TopXMLNS, _attrs, _val,
				 Seconds);
decode_multi_last_item_attrs(__TopXMLNS,
			     [{<<"seconds">>, _val} | _attrs], Jid, _Seconds) ->
    decode_multi_last_item_attrs(__TopXMLNS, _attrs, Jid,
				 _val);
decode_multi_last_item_attrs(__TopXMLNS, [_ | _attrs],
			     Jid, Seconds) ->
    decode_multi_last_item_attrs(__TopXMLNS, _attrs, Jid,
				 Seconds);
decode_multi_last_item_attrs(__TopXMLNS, [], Jid,
			     Seconds) ->
    {decode_multi_last_item_attr_jid(__TopXMLNS, Jid),
     decode_multi_last_item_attr_seconds(__TopXMLNS,
					 Seconds)}.

encode_multi_last_item({multi_last_item, Jid, Seconds},
		       __TopXMLNS) ->
    __NewTopXMLNS =
	xmpp_codec:choose_top_xmlns(<<"jabber:iq:multi:last">>,
				    [], __TopXMLNS),
    _els = [],
    _attrs = encode_multi_last_item_attr_seconds(Seconds,
						 encode_multi_last_item_attr_jid(Jid,
										 xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
													    __TopXMLNS))),
    {xmlel, <<"item">>, _attrs, _els}.

decode_multi_last_item_attr_jid(__TopXMLNS,
				undefined) ->
    erlang:error({xmpp_codec,
		  {missing_attr, <<"jid">>, <<"item">>, __TopXMLNS}});
decode_multi_last_item_attr_jid(__TopXMLNS, _val) ->
    case catch jid:decode(_val) of
      {'EXIT', _} ->
	  erlang:error({xmpp_codec,
			{bad_attr_value, <<"jid">>, <<"item">>, __TopXMLNS}});
      _res -> _res
    end.

encode_multi_last_item_attr_jid(_val, _acc) ->
    [{<<"jid">>, jid:encode(_val)} | _acc].

decode_multi_last_item_attr_seconds(__TopXMLNS,
				    undefined) ->
    none;
decode_multi_last_item_attr_seconds(__TopXMLNS, _val) ->
    case catch dec_int(_val, 0, infinity) of
      {'EXIT', _} ->
	  erlang:error({xmpp_codec,
			{bad_attr_value, <<"seconds">>, <<"item">>,
			 __TopXMLNS}});
      _res -> _res
    end.

encode_multi_last_item_attr_seconds(none, _acc) -> _acc;
encode_multi_last_item_attr_seconds(_val, _acc) ->
    [{<<"seconds">>, enc_int(_val)} | _acc].
