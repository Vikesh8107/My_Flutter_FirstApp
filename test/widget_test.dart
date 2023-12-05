import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my/main.dart';

void main() {
  testWidgets('StockPage displays stock information', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: StockPage()));

    // Verify that the StockPage is displayed.
    expect(find.byType(StockPage), findsOneWidget);

    // For simplicity, let's assume the first stock is displayed in the list.
    // Replace with actual test logic based on your UI structure.
    expect(find.text('Stock0'), findsOneWidget);
    expect(find.textContaining('Price: \$'), findsOneWidget);

    // You can add more test cases based on your UI structure and requirements.
  });
}
