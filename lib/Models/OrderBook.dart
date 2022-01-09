import 'dart:math';

import 'CurrencyPair.dart';

class OrderBook {

  late List<Order> asks;
  late List<Order> bids;

  OrderBook(this.asks, this.bids);

  OrderBook.fromJson(Map<String, dynamic> json) {
    var orderLimit = 5;

    var asksValues = List<dynamic>.from(json["asks"]).map((e) => Order(double.tryParse((e as List).first)!, double.tryParse((e).last)!)).toList();
    asksValues.sort((a,b) => b.price.compareTo(a.price));
    asksValues = asksValues.getRange(0, min(asksValues.length, orderLimit)).toList();

    var bidValues = List<dynamic>.from(json["bids"]).map((e) => Order(double.tryParse((e as List).first)!, double.tryParse((e).last)!)).toList();
    bidValues.sort((a,b) => a.price.compareTo(b.price));
    bidValues = bidValues.getRange(0, min(bidValues.length, orderLimit)).toList();

    asks = asksValues;
    bids = bidValues;
  }
}

class Order {

  double price;
  double quantity;

  Order(this.price, this.quantity);
}