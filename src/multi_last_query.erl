%% Created automatically by XML generator (fxml_gen.erl)
%% Source: xmpp_codec.spec

-module(multi_last_query).

-compile(export_all).

do_decode(<<"query">>, <<"jabber:iq:multi:last">>, El,
	  Opts) ->
    decode_multi_last_query(<<"jabber:iq:multi:last">>,
			    Opts, El);
do_decode(Name, <<>>, _, _) ->
    erlang:error({xmpp_codec, {missing_tag_xmlns, Name}});
do_decode(Name, XMLNS, _, _) ->
    erlang:error({xmpp_codec, {unknown_tag, Name, XMLNS}}).

tags() -> [{<<"query">>, <<"jabber:iq:multi:last">>}].

do_encode({multi_last_query, _, _} = Query, TopXMLNS) ->
    encode_multi_last_query(Query, TopXMLNS).

do_get_name({multi_last_query, _, _}) -> <<"query">>.

do_get_ns({multi_last_query, _, _}) ->
    <<"jabber:iq:multi:last">>.

pp(multi_last_query, 2) -> [items, ver];
pp(_, _) -> no.

records() -> [{multi_last_query, 2}].

decode_multi_last_query(__TopXMLNS, __Opts,
			{xmlel, <<"query">>, _attrs, _els}) ->
    Items = decode_multi_last_query_els(__TopXMLNS, __Opts,
					_els, []),
    Ver = decode_multi_last_query_attrs(__TopXMLNS, _attrs,
					undefined),
    {multi_last_query, Items, Ver}.

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
				      [multi_last_item:decode_multi_last_item(<<"jabber:iq:multi:last">>,
									      __Opts,
									      _el)
				       | Items]);
      _ ->
	  decode_multi_last_query_els(__TopXMLNS, __Opts, _els,
				      Items)
    end;
decode_multi_last_query_els(__TopXMLNS, __Opts,
			    [_ | _els], Items) ->
    decode_multi_last_query_els(__TopXMLNS, __Opts, _els,
				Items).

decode_multi_last_query_attrs(__TopXMLNS,
			      [{<<"ver">>, _val} | _attrs], _Ver) ->
    decode_multi_last_query_attrs(__TopXMLNS, _attrs, _val);
decode_multi_last_query_attrs(__TopXMLNS, [_ | _attrs],
			      Ver) ->
    decode_multi_last_query_attrs(__TopXMLNS, _attrs, Ver);
decode_multi_last_query_attrs(__TopXMLNS, [], Ver) ->
    decode_multi_last_query_attr_ver(__TopXMLNS, Ver).

encode_multi_last_query({multi_last_query, Items, Ver},
			__TopXMLNS) ->
    __NewTopXMLNS =
	xmpp_codec:choose_top_xmlns(<<"jabber:iq:multi:last">>,
				    [], __TopXMLNS),
    _els =
	lists:reverse('encode_multi_last_query_$items'(Items,
						       __NewTopXMLNS, [])),
    _attrs = encode_multi_last_query_attr_ver(Ver,
					      xmpp_codec:enc_xmlns_attrs(__NewTopXMLNS,
									 __TopXMLNS)),
    {xmlel, <<"query">>, _attrs, _els}.

'encode_multi_last_query_$items'([], __TopXMLNS,
				 _acc) ->
    _acc;
'encode_multi_last_query_$items'([Items | _els],
				 __TopXMLNS, _acc) ->
    'encode_multi_last_query_$items'(_els, __TopXMLNS,
				     [multi_last_item:encode_multi_last_item(Items,
									     __TopXMLNS)
				      | _acc]).

decode_multi_last_query_attr_ver(__TopXMLNS,
				 undefined) ->
    undefined;
decode_multi_last_query_attr_ver(__TopXMLNS, _val) ->
    _val.

encode_multi_last_query_attr_ver(undefined, _acc) ->
    _acc;
encode_multi_last_query_attr_ver(_val, _acc) ->
    [{<<"ver">>, _val} | _acc].
