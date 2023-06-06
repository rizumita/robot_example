import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robot_example/search_view.dart';

import 'robot.dart';

class SearchViewRobot extends Robot<SearchView> {
  SearchViewRobot(super.tester, super.parent) : super.child();

  // Data}

  // Finders

  Finder get searchAnchor => find.descendant(of: this, matching: find.byType(SearchAnchor));

  // Parent下には存在しない
  Finder get textField => find.byType(TextField);
  Finder itemCell(Key key) => find.byKey(key);

  // Actions

  Future tapStartSearchingButton() async {
    await tester.tap(searchAnchor);
    await tester.pumpAndSettle();
  }

  // Expectations

  expectIsDisabled() => expect(this, findsNothing);
  expectIsEnabled() => expect(searchAnchor, findsOneWidget);

  expectSearchFieldToBeHidden() => expect(textField, findsNothing);
  expectSearchFieldToBeShown() => expect(textField, findsOneWidget);

  enterSearchText(String s) async {
    await tester.enterText(textField, s);
    await tester.pumpAndSettle();
  }

  expectItemCellToBeShown({required Key key}) => expect(itemCell(key), findsOneWidget);

  expectNoItemCellNotToBeShown({required Key key}) => expect(itemCell(key), findsNothing);
}
