
import 'package:deep_rooted/Models/CurrencyPair.dart';
import 'package:deep_rooted/ViewModelState.dart';
import 'package:deep_rooted/TickerService.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'Models/OrderBook.dart';

class SearchCurrencyPairViewModel with ChangeNotifier {

  ICurrencyPairService service = CurrencyPairService();

  ViewModelState<CurrencyPair> modelState = ViewModelState.initial('Enter a currency pair to load details');
  ViewModelState<OrderBook> orderBookState = ViewModelState.initial('Enter a currency pair to load order book');

  String? searchTerm;
  String? updateDate;

  bool get showRefreshButton => modelState.status == Status.completed && modelState.data != null;

  Future<void> fetchCurrencyPair() async {
    modelState = ViewModelState.loading('Fetching currency pair detail');
    orderBookState = ViewModelState.initial('');
    notifyListeners();
    try {
      var detail = await service.fetchCurrencyPairDetail(searchTerm!);
      modelState = ViewModelState.completed(detail);
      var now = DateTime.now();
      final DateFormat formatter = DateFormat('dd-MM-yyyy, H:m:s');
      updateDate = formatter.format(now);
      fetchOrderBook();
    } catch (error) {
      modelState = ViewModelState.error(error.toString());
    }

    notifyListeners();
  }

  Future<void> fetchOrderBook() async {
    orderBookState = ViewModelState.loading('Fetching order book detail');
    notifyListeners();
    try {
      var detail = await service.fetchOrderBook(searchTerm!);
      orderBookState = ViewModelState.completed(detail);
    } catch (error) {
      orderBookState = ViewModelState.error(error.toString());
    }

    notifyListeners();
  }

}
