import 'package:deep_rooted/Models/CurrencyPair.dart';
import 'package:deep_rooted/Models/OrderBook.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  test("Currency pair should have been correctly parsed", () async {
    var currencyPair = CurrencyPair.fromJson("test",{
      'open': '1234.56',
      'high': '2345.67',
      'low': '3456.78',
      'last': '4567.89',
      'volume': '5678.90'
    });

    expect(currencyPair.last.price, 4567.89, reason: "Currency pair last value should have been correctly parsed");
    expect(currencyPair.open.price, 1234.56, reason: "Currency pair open value should have been correctly parsed");
    expect(currencyPair.high.price, 2345.67, reason: "Currency pair high value should have been correctly parsed");
    expect(currencyPair.low.price, 3456.78, reason: "Currency pair low value should have been correctly parsed");
    expect(currencyPair.volume, 5678.90, reason: "Currency pair volume should have been correctly parsed");
  });

  test("Order book should have been correctly parsed & sorted", () async {
    var orderBook = OrderBook.fromJson({
      'asks': [
        ["1.2", "0.12"],
        ["5.6", "0.45"],
        ["2.3", "0.23"],
        ["3.4", "0.34"]
      ],
      'bids': [
        ["6.7", "0.67"],
        ["7.8", "0.78"],
        ["8.9", "0.89"],
        ["11.12", "11.12"],
        ["9.1", "0.91"],
        ["10.11", "10.11"]
      ]
    });

    expect(orderBook.asks.length, 4, reason:"Order book should have correct number of 'asks' orders");
    expect(orderBook.bids.length, 5, reason:"Order book should not have more than 5 'bids' orders");
    expect(orderBook.asks.first.price, 5.6, reason: "Order book 'asks' orders should be descending");
    expect(orderBook.bids.first.price, 6.7, reason: "Order book 'bids' orders should be ascending");
  });
}
