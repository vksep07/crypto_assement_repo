// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:crypto_assignment/main.dart';

void main() {
  testWidgets('testing listview widget', (WidgetTester tester) async {
    // the items to add to list
    List<String> listItems = ["item 1","item 2","item 3"];

    //start the widget
    await tester.pumpWidget(
        MaterialApp(home: ListAppWidget(listItems))
    );

    //find all text widgets
    List<Widget> asd = tester.widgetList(find.byType(Text)).toList();
    int n = 0;

    //verify
    asd.forEach((element) {
      expect(element.toString().contains(listItems[n]), true, reason: "Not found");
      print(listItems[n] + " found");
      n += 1;
    });
  });
}
