import 'package:deep_rooted/Models/CurrencyPair.dart';
import 'package:deep_rooted/ViewModelState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyPairDetailWidget extends StatelessWidget {
  const CurrencyPairDetailWidget({Key? key, required this.viewModelState}) : super(key: key);

  final ViewModelState<CurrencyPair> viewModelState;

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
        return const Text("Error loading currency pair details");
      case Status.completed:
        if (viewModelState.data == null) return Container();
        var currencyPair = viewModelState.data!;
        return Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(currencyPair.name.toUpperCase(), textDirection: TextDirection.ltr, style:
                      const TextStyle(fontWeight: FontWeight.w400, fontSize: 32) ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(currencyPair.updateDate, textDirection: TextDirection.ltr, style: const TextStyle(fontSize: 12)),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      PriceStageWidget(priceStage: currencyPair.open),
                      const Spacer(),
                      PriceStageWidget(priceStage: currencyPair.high)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      PriceStageWidget(priceStage: currencyPair.low),
                      const Spacer(),
                      PriceStageWidget(priceStage: currencyPair.last)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      PriceStageWidget(priceStage: PriceStage("VOLUME", 8034.7899))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }
}

class PriceStageWidget extends StatelessWidget {
  const PriceStageWidget({Key? key, required this.priceStage}) : super(key: key);

  final PriceStage priceStage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(priceStage.stageName, textAlign: TextAlign.left, textDirection: TextDirection.ltr, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
        Text(priceStage.price.toString(), textAlign: TextAlign.left, textDirection: TextDirection.ltr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
      ],
    );
  }
}