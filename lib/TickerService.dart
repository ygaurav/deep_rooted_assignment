import 'dart:convert';
import 'package:deep_rooted/Models/CurrencyPair.dart';
import 'package:http/http.dart' show Client;

import 'Models/OrderBook.dart';


abstract class ICurrencyPairService {
   fetchCurrencyPairDetail(String name);
   fetchOrderBook(String name);
}

class CurrencyPairService implements ICurrencyPairService {

  Client client = Client();

  @override
  fetchCurrencyPairDetail(String name) async {

    final response = await client.get(Uri.parse("https://www.bitstamp.net/api/v2/ticker/$name"));

    var currencyPair = CurrencyPair.fromJson(name, json.decode(response.body));

    return currencyPair;
  }

  @override
  fetchOrderBook(String name) async {
    final response = await client.get(Uri.parse("https://www.bitstamp.net/api/v2/order_book/$name"));

    var currencyPair = OrderBook.fromJson(json.decode(response.body));

    return currencyPair;

  }


}