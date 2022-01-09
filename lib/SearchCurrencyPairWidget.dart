import 'package:deep_rooted/CurrencyPairDetailWidget.dart';
import 'package:deep_rooted/OrderBookWidget.dart';
import 'package:deep_rooted/SearchCurrencyPairViewModel.dart';
import 'package:deep_rooted/ViewModelState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/CurrencyPair.dart';

class SearchCurrencyPairWidget extends StatefulWidget {
  const SearchCurrencyPairWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SearchCurrencyPairWidget> createState() => _SearchCurrencyPairWidgetState();
}

class _SearchCurrencyPairWidgetState extends State<SearchCurrencyPairWidget> {

  bool showOrderBook = false;

  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<SearchCurrencyPairViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: CupertinoSearchTextField(
                    placeholder: "Enter currency pair",
                    autocorrect: false,
                    padding: const EdgeInsets.all(16),
                    onSubmitted: (String value) {
                      viewModel.searchTerm = value;
                      viewModel.fetchCurrencyPair();
                    }
                ),
              ),
              Consumer<SearchCurrencyPairViewModel>(builder: (context, viewModel, abc) {
                return Column(
                  children: [
                    CurrencyPairDetailWidget(viewModelState: viewModel.modelState),
                    if (viewModel.modelState.data != null)
                      Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(onPressed: _updateOrderBookButton, child: showOrderBook ? const Text("HIDE ORDER BOOK") : const Text("SHOW ORDER BOOK")),
                    )
                  ],
                );
              }),
              if(showOrderBook)
                Consumer<SearchCurrencyPairViewModel>(builder: (context, viewModel, abc) {
                  return OrderBookWidget(viewModelState: viewModel.orderBookState);
                })
            ],
          ),
        ),
      ),
      floatingActionButton: !viewModel.showRefreshButton ? Container() : FloatingActionButton(
        onPressed: () {
          viewModel.fetchCurrencyPair();
        },
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void _updateOrderBookButton() {
    setState(() {
      showOrderBook = !showOrderBook;
    });
  }

}
