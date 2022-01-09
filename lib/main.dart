import 'package:deep_rooted/SearchCurrencyPairViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'SearchCurrencyPairWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<SearchCurrencyPairViewModel>(
        create: (context) => SearchCurrencyPairViewModel(),
        child: const SearchCurrencyPairWidget(title: 'Currency Pair'),
      ),
    );
  }
}
