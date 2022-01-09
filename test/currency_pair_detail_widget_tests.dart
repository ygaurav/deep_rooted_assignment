import 'package:deep_rooted/CurrencyPairDetailWidget.dart';
import 'package:deep_rooted/Models/CurrencyPair.dart';
import 'package:deep_rooted/ViewModelState.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  testWidgets('CurrencyPair detail widget is correctly setup', (WidgetTester tester) async {
    var currencyPairDetail = CurrencyPair("test-currency",
        PriceStage("test-stage-open",1.2),
        PriceStage("test-stage-high", 2.3),
        PriceStage("test-stage-low", 3.4),
        PriceStage("test-stage-last", 4.5),
        5.6, "updateDate");

    await tester.pumpWidget(CurrencyPairDetailWidget(viewModelState: ViewModelState.completed(currencyPairDetail)));

    final currencyPairTitle = find.text('test-currency');

    expect(currencyPairTitle, "test-currency", reason: "Currency Pair title should have been present");
  });
}
