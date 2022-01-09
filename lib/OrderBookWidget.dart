import 'package:deep_rooted/ViewModelState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Models/OrderBook.dart';

class OrderBookWidget extends StatelessWidget {
  const OrderBookWidget({Key? key, required this.viewModelState}) : super(key: key);

  final ViewModelState<OrderBook> viewModelState;

  @override
  Widget build(BuildContext context) {
    switch (viewModelState.status) {
      case Status.initial:
        return Container();
      case Status.loading:
        return Column(
            children: const [
              CupertinoActivityIndicator(),
              SizedBox(height: 16),
              Text("Loading")
            ]
        );
      case Status.error:
        return const Text("Error loading order book");
      case Status.completed:
        if (viewModelState.data == null) return Container();

        return Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text("ORDER BOOK", textAlign: TextAlign.left, textDirection: TextDirection.ltr, style: TextStyle(fontWeight: FontWeight.w500))),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      OrderBookColumnWidget(leadingColumn: "BID PRICE", trailingColumn: "QTY", orders: viewModelState.data!.asks),
                      const Spacer(),
                      OrderBookColumnWidget(leadingColumn: "QTY", trailingColumn: "ASK PRICE", orders: viewModelState.data!.bids)
                    ],
                  ),
                )
              ],
            ),
          ),
        );
    }
  }
}

class OrderBookColumnWidget extends StatelessWidget {
  const OrderBookColumnWidget({Key? key, required this.leadingColumn, required this.trailingColumn, required this.orders }) : super(key: key);

  final String leadingColumn;
  final String trailingColumn;
  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: FractionallySizedBox(
        widthFactor: 0.44,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: Row(
                children: [
                  Text(leadingColumn),
                  const Spacer(),
                  Text(trailingColumn)
                ],
              ),
            ),
            SizedBox(
              width: 165,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orders.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Text(orders.elementAt(index).price.toString(), style: const TextStyle(fontSize: 12)),
                          const Spacer(),
                          Text(orders.elementAt(index).quantity.toString(), style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}

class BidPriceWidget extends StatelessWidget {
  const BidPriceWidget({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${order.price}", textAlign: TextAlign.left, style: const TextStyle(fontSize: 12)),
        Text("${order.quantity}", textAlign: TextAlign.right, style: const TextStyle(fontSize: 12))
      ],
    );
  }
}

class AskPriceWidget extends StatelessWidget {
  const AskPriceWidget({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${order.quantity}", textAlign: TextAlign.right, style: const TextStyle(fontSize: 12)),
        Text("${order.price}", textAlign: TextAlign.left, style: const TextStyle(fontSize: 12))
      ],
    );
  }
}