import 'package:deep_rooted/Models/OrderBook.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';
import 'package:deep_rooted/TickerService.dart';

void main(){

  test("Correctly parse valid response", () async {
    final tickerService = CurrencyPairService();

    tickerService.client = MockClient((request) async {
      final jsonMap = {
        'open': '1234.56',
        'high': '2345.67',
        'low': '3456.78',
        'last': '4567.89',
        'volume': '5678.90'
      };
      return Response(json.encode(jsonMap), 200);
    });

    final currencyPair = await tickerService.fetchCurrencyPairDetail("btcuds");

    expect('btcuds', currencyPair.name);
    expect(1234.56, currencyPair.open.price);
    expect(2345.67, currencyPair.high.price);
    expect(3456.78, currencyPair.low.price);
    expect(4567.89, currencyPair.last.price);
    expect(5678.90, currencyPair.volume);
  });

  test("Correctly parse valid OrderBook response", () async {
    final tickerService = CurrencyPairService();

    tickerService.client = MockClient((request) async {
      final jsonMap = {
        'asks': [
          ["1.2", "0.12"],
          ["2.3", "0.23"],
          ["3.4", "0.34"],
          ["5.6", "0.45"]
        ],
        'bids': [
          ["6.7", "0.67"],
          ["7.8", "0.78"],
          ["8.9", "0.89"],
          ["9.1", "0.91"],
          ["10.11", "10.11"],
          ["11.12", "11.12"]
        ]
      };
      return Response(json.encode(jsonMap), 200);
    });


    final OrderBook orderBook = await tickerService.fetchOrderBook("test");;

    expect(4, orderBook.asks.length);
    expect(5, orderBook.bids.length);
  });
}