%% Created automatically by XML generator (fxml_gen.erl)
%% Source: xmpp_codec.spec

-module(multi_last).

-compile(export_all).

do_decode(<<"query">>, <<"jabber:iq:multi:last">>, El,
	  Opts) ->
    decode_multi_last_query(<<"jabber:iq:multi:last">>,
			    Opts, El);
do_decode(<<"item">>, <<"jabber:iq:multi:last">>, El,
	  Opts) ->
    decode_multi_last_item(<<"jabber:iq:multi:last">>, Opts,
			   El);
do_decode(<<"error">>, <<"jabber:iq:multi:last">>, El,
	  Opts) ->
    decode_multi_last_error(<<"jabber:iq:multi:last">>,
			    Opts, El);
do_decode(Name, <<>>, _, _) ->
    erlang:error({xmpp_codec, {missing_tag_xmlns, Name}});
do_decode(Name, XMLNS, _, _) ->
    erlang:error({xmpp_codec, {unknown_tag, Name, XMLNS}}).

tags() ->
    [{<<"query">>, <<"jabber:iq:multi:last">>},
     {<<"item">>, <<"jabber:iq:multi:last">>},
     {<<"error">>, <<"jabber:iq:multi:last">>}].

do_encode({multi_last_error, _, _} = Error, TopXMLNS) ->
    encode_multi_last_error(Error, TopXMLNS);
do_encode({multi_last_item, _, _, _, _} = Item,
	  TopXMLNS) ->
    encode_multi_last_item(Item, TopXMLNS);
do_encode({multi_last_query, _} = Query, TopXMLNS) ->
    encode_multi_last_query(Query, TopXMLNS).

do_get_name({multi_last_error, _, _}) -> <<"error">>;
do_get_name({multi_last_item, _, _, _, _}) ->
    <<"item">>;
do_get_name({multi_last_query, _}) -> <<"query">>.

do_get_ns({multi_last_error, _, _}) ->
    <<"jabber:iq:multi:last">>;
do_get_ns({multi_last_item, _, _, _, _}) ->
    <<"jabber:iq:multi:last">>;
do_get_ns({multi_last_query, _}) ->
    <<"jabber:iq:multi:last">>.

pp(multi_last_error, 2) -> [code, reason];
pp(multi_last_item, 4) -> [jid, seconds, status, error];
pp(multi_last_query, 1) -> [items];
pp(_, _) -> no.

records() ->
    [{multi_last_error, 2}, {multi_last_item, 4},
     {multi_last_query, 1}].

dec_int(Val) -> dec_int(Val, infinity, infinity).

dec_int(Val, Min, Max) ->
    case erlang:binary_to_integer(Val) of
      Int when Int =< Max, Min == infinity -> Int;
      Int when Int =< Max, Int >= Min -> Int
    end.

enc_int(Int) -> erlang:integer_to_binary(Int).

decode_multi_last_query(__TopXMLNS, __Opts,
			{xmlel, <<"query">>, _attrs, _els}) ->
    Items = decode_multi_last_query_els(__TopXMLNS, __Opts,
					_els, []),
    {multi_last_query, Items}.

decode_multi_last_query_els(__TopXMLNS, __Opts, [],
			    Items) ->
    lists:reverse(Items);
decode_multi_last_query_els(__TopXMLNS, __Opts,
			    [{xmlel, <<"item">>, _attrs, _} = _el | _els],
			    Items) ->
    case xmpp_codec:get_attr(<<"xmlns">>, _attrs,
			     __TopXMLNS)
	of
      <<"jabber:iq:multi:last">> ->
	  decode_multi_last_query_els(__TopXMLNS, __Opts, _els,
				      [decode_multi_last_item(<<"jabber:iq:multi:last">>,
							      __Opts, _el)
				       | Items]);
      _ ->
	  decode_multi_last_query_els(__TopXMLNS, __Opts, _els,
				      Items)
    end;
decode_multi_last_query_els(__TopXMLNS, __Opts,
			    [_ | _els], Items) ->
    decode_multi_last_query_els(__TopXMLNS, __Opts, _els,
				Items).

encode_multi_last_query({multi_last_query, Items},
			__TopXMLNS) ->
    __NewTopXMLNS =
	xmpp_codec:choose_top_xmlns(<<"jabber:iq:multi:last">>,
				    [], __TopXMLNS),
    _els =
	lists:reverse('encode_multi_last_query_$items'(Items,
						       __NewTopXMLNS, [])),
    _attrs = xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
					__TopXMLNS),
    {xmlel, <<"query">>, _attrs, _els}.

'encode_multi_last_query_$items'([], __TopXMLNS,
				 _acc) ->
    _acc;
'encode_multi_last_query_$items'([Items | _els],
				 __TopXMLNS, _acc) ->
    'encode_multi_last_query_$items'(_els, __TopXMLNS,
				     [encode_multi_last_item(Items, __TopXMLNS)
				      | _acc]).

decode_multi_last_item(__TopXMLNS, __Opts,
		       {xmlel, <<"item">>, _attrs, _els}) ->
    {Status, Error} = decode_multi_last_item_els(__TopXMLNS,
						 __Opts, _els, <<>>, []),
    {Jid, Seconds} =
	decode_multi_last_item_attrs(__TopXMLNS, _attrs,
				     undefined, undefined),
    {multi_last_item, Jid, Seconds, Status, Error}.

decode_multi_last_item_els(__TopXMLNS, __Opts, [],
			   Status, Error) ->
    {decode_multi_last_item_cdata(__TopXMLNS, Status),
     lists:reverse(Error)};
decode_multi_last_item_els(__TopXMLNS, __Opts,
			   [{xmlcdata, _data} | _els], Status, Error) ->
    decode_multi_last_item_els(__TopXMLNS, __Opts, _els,
			       <<Status/binary, _data/binary>>, Error);
decode_multi_last_item_els(__TopXMLNS, __Opts,
			   [{xmlel, <<"error">>, _attrs, _} = _el | _els],
			   Status, Error) ->
    case xmpp_codec:get_attr(<<"xmlns">>, _attrs,
			     __TopXMLNS)
	of
      <<"jabber:iq:multi:last">> ->
	  decode_multi_last_item_els(__TopXMLNS, __Opts, _els,
				     Status,
				     [decode_multi_last_error(<<"jabber:iq:multi:last">>,
							      __Opts, _el)
				      | Error]);
      _ ->
	  decode_multi_last_item_els(__TopXMLNS, __Opts, _els,
				     Status, Error)
    end;
decode_multi_last_item_els(__TopXMLNS, __Opts,
			   [_ | _els], Status, Error) ->
    decode_multi_last_item_els(__TopXMLNS, __Opts, _els,
			       Status, Error).

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

encode_multi_last_item({multi_last_item, Jid, Seconds,
			Status, Error},
		       __TopXMLNS) ->
    __NewTopXMLNS =
	xmpp_codec:choose_top_xmlns(<<"jabber:iq:multi:last">>,
				    [], __TopXMLNS),
    _els =
	lists:reverse(encode_multi_last_item_cdata(Status,
						   'encode_multi_last_item_$error'(Error,
										   __NewTopXMLNS,
										   []))),
    _attrs = encode_multi_last_item_attr_seconds(Seconds,
						 encode_multi_last_item_attr_jid(Jid,
										 xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
													    __TopXMLNS))),
    {xmlel, <<"item">>, _attrs, _els}.

'encode_multi_last_item_$error'([], __TopXMLNS, _acc) ->
    _acc;
'encode_multi_last_item_$error'([Error | _els],
				__TopXMLNS, _acc) ->
    'encode_multi_last_item_$error'(_els, __TopXMLNS,
				    [encode_multi_last_error(Error, __TopXMLNS)
				     | _acc]).

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
    undefined;
decode_multi_last_item_attr_seconds(__TopXMLNS, _val) ->
    case catch dec_int(_val, 0, infinity) of
      {'EXIT', _} ->
	  erlang:error({xmpp_codec,
			{bad_attr_value, <<"seconds">>, <<"item">>,
			 __TopXMLNS}});
      _res -> _res
    end.

encode_multi_last_item_attr_seconds(undefined, _acc) ->
    _acc;
encode_multi_last_item_attr_seconds(_val, _acc) ->
    [{<<"seconds">>, enc_int(_val)} | _acc].

decode_multi_last_item_cdata(__TopXMLNS, <<>>) -> <<>>;
decode_multi_last_item_cdata(__TopXMLNS, _val) -> _val.

encode_multi_last_item_cdata(<<>>, _acc) -> _acc;
encode_multi_last_item_cdata(_val, _acc) ->
    [{xmlcdata, _val} | _acc].

decode_multi_last_error(__TopXMLNS, __Opts,
			{xmlel, <<"error">>, _attrs, _els}) ->
    Reason = decode_multi_last_error_els(__TopXMLNS, __Opts,
					 _els, <<>>),
    Code = decode_multi_last_error_attrs(__TopXMLNS, _attrs,
					 undefined),
    {multi_last_error, Code, Reason}.

decode_multi_last_error_els(__TopXMLNS, __Opts, [],
			    Reason) ->
    decode_multi_last_error_cdata(__TopXMLNS, Reason);
decode_multi_last_error_els(__TopXMLNS, __Opts,
			    [{xmlcdata, _data} | _els], Reason) ->
    decode_multi_last_error_els(__TopXMLNS, __Opts, _els,
				<<Reason/binary, _data/binary>>);
decode_multi_last_error_els(__TopXMLNS, __Opts,
			    [_ | _els], Reason) ->
    decode_multi_last_error_els(__TopXMLNS, __Opts, _els,
				Reason).

decode_multi_last_error_attrs(__TopXMLNS,
			      [{<<"code">>, _val} | _attrs], _Code) ->
    decode_multi_last_error_attrs(__TopXMLNS, _attrs, _val);
decode_multi_last_error_attrs(__TopXMLNS, [_ | _attrs],
			      Code) ->
    decode_multi_last_error_attrs(__TopXMLNS, _attrs, Code);
decode_multi_last_error_attrs(__TopXMLNS, [], Code) ->
    decode_multi_last_error_attr_code(__TopXMLNS, Code).

encode_multi_last_error({multi_last_error, Code,
			 Reason},
			__TopXMLNS) ->
    __NewTopXMLNS =
	xmpp_codec:choose_top_xmlns(<<"jabber:iq:multi:last">>,
				    [], __TopXMLNS),
    _els = encode_multi_last_error_cdata(Reason, []),
    _attrs = encode_multi_last_error_attr_code(Code,
					       xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
									  __TopXMLNS)),
    {xmlel, <<"error">>, _attrs, _els}.

decode_multi_last_error_attr_code(__TopXMLNS,
				  undefined) ->
    erlang:error({xmpp_codec,
		  {missing_attr, <<"code">>, <<"error">>, __TopXMLNS}});
decode_multi_last_error_attr_code(__TopXMLNS, _val) ->
    case catch dec_int(_val) of
      {'EXIT', _} ->
	  erlang:error({xmpp_codec,
			{bad_attr_value, <<"code">>, <<"error">>, __TopXMLNS}});
      _res -> _res
    end.

encode_multi_last_error_attr_code(_val, _acc) ->
    [{<<"code">>, enc_int(_val)} | _acc].

decode_multi_last_error_cdata(__TopXMLNS, <<>>) -> <<>>;
decode_multi_last_error_cdata(__TopXMLNS, _val) -> _val.

encode_multi_last_error_cdata(<<>>, _acc) -> _acc;
encode_multi_last_error_cdata(_val, _acc) ->
    [{xmlcdata, _val} | _acc].
