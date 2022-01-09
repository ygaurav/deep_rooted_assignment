import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

@visibleForTesting
class CurrencyPair {
  @visibleForTesting
  String name;
  PriceStage open;
  PriceStage high;
  PriceStage low;
  PriceStage last;
  double volume;
  String updateDate;
  static final formatter = DateFormat('dd-MM-yyyy, H:mm:ss');

  CurrencyPair(
      this.name, this.open, this.high, this.low, this.last, this.volume, this.updateDate);

  CurrencyPair.fromJson(this.name, Map<String, dynamic> json) :
        open = PriceStage("Open", double.parse(json["open"])),
        high = PriceStage("High", double.parse(json["high"])),
        low = PriceStage("Low", double.parse(json["low"])),
        last = PriceStage("Last", double.parse(json["last"])),
        volume = double.parse(json["volume"]),
        updateDate = formatter.format(DateTime.now());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyPair &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          open == other.open &&
          high == other.high &&
          low == other.low &&
          last == other.last &&
          volume == other.volume;

  @override
  int get hashCode =>
      name.hashCode ^
      open.hashCode ^
      high.hashCode ^
      low.hashCode ^
      last.hashCode ^
      volume.hashCode;
}

class PriceStage {

  String stageName;
  double price;

  PriceStage(this.stageName, this.price);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceStage &&
          runtimeType == other.runtimeType &&
          stageName == other.stageName &&
          price == other.price;

  @override
  int get hashCode => stageName.hashCode ^ price.hashCode;
}