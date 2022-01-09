import 'package:deep_rooted/Models/OrderBook.dart';
import 'package:deep_rooted/SearchCurrencyPairViewModel.dart';
import 'package:deep_rooted/Models/CurrencyPair.dart';
import 'package:deep_rooted/ViewModelState.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deep_rooted/TickerService.dart';

void main(){

  late ICurrencyPairService service;

  test("ViewModel Should update on service success", () async {
    var mockService = MockTickerService();
    mockService.mockCurrencyPairResponse = CurrencyPair("test", PriceStage("a", 1), PriceStage("b", 2), PriceStage("c", 1), PriceStage("d", 1.5), 22, "");
    service = mockService;
    final viewModel = SearchCurrencyPairViewModel();
    viewModel.searchTerm = "test";
    viewModel.service = mockService;

    expect(viewModel.modelState.status, Status.initial, reason: "ViewModel state should be Initial");

    await viewModel.fetchCurrencyPair();

    expect(viewModel.modelState.status, Status.completed, reason: "ViewModel state should have been COMPLETED");
    expect(viewModel.modelState.data, mockService.mockCurrencyPairResponse, reason: "ViewModel Currency pair is incorrect");
  });

  test("ViewModel Should update on service failure", () async {
    var mockService = MockTickerService();
    mockService.shouldThrow = true;
    service = mockService;
    final viewModel = SearchCurrencyPairViewModel();
    viewModel.searchTerm = "test";
    viewModel.service = service;
                                                                        
    expect(viewModel.modelState.status, Status.initial, reason: "ViewModel state should be Initial");

    await viewModel.fetchCurrencyPair();

    expect(viewModel.modelState.status, Status.error, reason: "ViewModel state should have been COMPLETED");
    expect(viewModel.modelState.message, "Exception: Mock exception", reason: "ViewModel Currency pair is incorrect");
  });

  test("ViewModel Should update state to Loading on service call", () async {
    var listenerCalled = 0;
    var mockService = MockTickerService();
    service = mockService;

    final viewModel = SearchCurrencyPairViewModel();
    viewModel.searchTerm = "test";
    viewModel.service = mockService;

    viewModel.addListener(() {
      listenerCalled += 1;
    });

    viewModel.fetchCurrencyPair();

    expect(listenerCalled, 2, reason: "Change notifier should have been called once");
  });

  test("ViewModel Should update order book on service success", () async {
    var mockService = MockTickerService();
    mockService.mockOrderBookResponse = OrderBook([Order(1.2, 0.12)], [Order(2.3, 0.23)]);
    service = mockService;
    final viewModel = SearchCurrencyPairViewModel();
    viewModel.searchTerm = "test";
    viewModel.service = mockService;

    expect(viewModel.orderBookState.status, Status.initial, reason: "ViewModel state should be Initial");

    await viewModel.fetchOrderBook();

    expect(viewModel.orderBookState.status, Status.completed, reason: "ViewModel state should have been COMPLETED");
    expect(viewModel.orderBookState.data, mockService.mockOrderBookResponse, reason: "ViewModel order book is incorrect");
  });

  test("ViewModel Should update order book on service failure", () async {
    var mockService = MockTickerService();
    mockService.shouldThrow = true;
    service = mockService;
    final viewModel = SearchCurrencyPairViewModel();
    viewModel.searchTerm = "test";
    viewModel.service = service;

    expect(viewModel.orderBookState.status, Status.initial, reason: "ViewModel order book state should be Initial");

    await viewModel.fetchOrderBook();

    expect(viewModel.orderBookState.status, Status.error, reason: "ViewModel order book state should have been COMPLETED");
    expect(viewModel.orderBookState.message, "Exception: Mock exception", reason: "ViewModel order book is incorrect");
  });
}

class MockTickerService implements ICurrencyPairService {

  late CurrencyPair mockCurrencyPairResponse;
  late OrderBook mockOrderBookResponse;
  var shouldThrow = false;

  @override
  fetchCurrencyPairDetail(String name) {
    if (shouldThrow) {
      throw Exception("Mock exception");
    }
    return mockCurrencyPairResponse;
  }

  @override
  fetchOrderBook(String name) {
    if (shouldThrow) {
      throw Exception("Mock exception");
    }
    return mockOrderBookResponse;
  }

}