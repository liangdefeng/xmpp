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

do_encode({multi_last_query, _} = Query, TopXMLNS) ->
    encode_multi_last_query(Query, TopXMLNS).

do_get_name({multi_last_query, _}) -> <<"query">>.

do_get_ns({multi_last_query, _}) ->
    <<"jabber:iq:multi:last">>.

pp(multi_last_query, 1) -> [items];
pp(_, _) -> no.

records() -> [{multi_last_query, 1}].

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
				     [multi_last_item:encode_multi_last_item(Items,
									     __TopXMLNS)
				      | _acc]).
