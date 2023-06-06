import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:page_object/page_object.dart';

class Robot<W extends Widget> extends PageObject {
  Robot(this.tester) : super(find.byType(W));

  Robot.child(this.tester, parent)
      : super(find.descendant(
          of: parent,
          matching: find.byType(W),
        ));

  final WidgetTester tester;

  Widget ready(Widget widget) => MaterialApp(home: widget);
}
