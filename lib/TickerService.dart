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

    final response = await client.get(Utility.withPath(Utility.tickerPath, name));

    var currencyPair = CurrencyPair.fromJson(name, json.decode(response.body));

    return currencyPair;
  }

  @override
  fetchOrderBook(String name) async {
    
    final response = await client.get(Utility.withPath(Utility.orderBookPath, name));

    var currencyPair = OrderBook.fromJson(json.decode(response.body));

    return currencyPair;
  }


}

class Utility {
  static const tickerPath = "ticker";
  static const orderBookPath = "order_book";

  static const basePath = "www.bitstamp.net";

  static Uri withPath(String service, String currencyName) {
    return Uri(scheme: "https", host: basePath, pathSegments: ["api", "v2", service, currencyName]);
  }
}
