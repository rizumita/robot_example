import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robot_example/home_screen.dart';
import 'package:robot_example/models/searchable_container.dart';

import 'robot.dart';
import 'search_view_robot.dart';

void main() {
  group('検索可能なアイテムが存在しないとき', () {
    final container = StubSearchableContainer(0);

    testWidgets('メッセージが表示される、かつ検索ができない', (tester) async {
      final robot = HomeRobot(tester)
        ..container = container
        ..searchItemBuilder = (_, __, ___) => throw UnimplementedError();

      await robot.showScreen();

      robot.expectNoItemsMessageToBeShown();
      robot.searchView.expectIsDisabled();
    });
  });

  group('検索可能なアイテムが存在するとき', () {
    final container = StubSearchableContainer(100);
    Widget searchItemBuilder(BuildContext context, StubSearchableItem item, bool isForSearchResult) =>
        Card(key: ValueKey('${item.index}_$isForSearchResult'), child: ListTile(title: Text(item.text)));

    testWidgets('検索可能なアイテムのセルが表示される', (tester) async {
      final robot = HomeRobot(tester)
        ..container = container
        ..searchItemBuilder = searchItemBuilder;

      await robot.showScreen();

      robot.expectNoItemsMessageToBeHidden();
      robot.searchView.expectIsEnabled();
      await robot.expectItemCellsToBeShown();
    });

    group('検索するとき', () {
      testWidgets('検索ボタンをタップすると検索UIが表示される', (tester) async {
        final robot = HomeRobot(tester)
          ..container = StubSearchableContainer(100)
          ..searchItemBuilder = searchItemBuilder;

        await robot.showScreen();

        robot.searchView.expectSearchFieldToBeHidden();
        await robot.searchView.tapStartSearchingButton();
        robot.searchView.expectSearchFieldToBeShown();
      });

      testWidgets('検索してヒットすると検索セルが表示される', (tester) async {
        final robot = HomeRobot(tester)
          ..container = StubSearchableContainer(100)
          ..searchItemBuilder = searchItemBuilder;

        await robot.showScreen();
        await robot.searchView.tapStartSearchingButton();
        await robot.searchView.enterSearchText('99');

        await robot.searchView.expectItemCellToBeShown(key: const ValueKey('99_true'));
      });
    });

    testWidgets('ヒットしなければ1件も表示されない', (tester) async {
      final robot = HomeRobot(tester)
        ..container = StubSearchableContainer(100)
        ..searchItemBuilder = searchItemBuilder;

      await robot.showScreen();
      await robot.searchView.tapStartSearchingButton();
      await robot.searchView.enterSearchText('100');

      robot.searchView.expectNoItemCellNotToBeShown(key: const ValueKey('100_true'));
    });
  });
}

class HomeRobot extends Robot<HomeScreen<StubSearchableItem>> {
  HomeRobot(super.tester);

  // Data

  late StubSearchableContainer container;
  late SearchItemBuilder<StubSearchableItem> searchItemBuilder;

  // Finders

  Finder get noItemsMessage => find.descendant(of: this, matching: find.byKey(HomeScreen.noItemsMessageKey));
  SearchViewRobot get searchView => SearchViewRobot(tester, this);
  Finder cell(StubSearchableItem item) =>
      find.descendant(of: this, matching: find.byKey(ValueKey('${item.index}_false')));
  Finder cellText(StubSearchableItem item) => find.descendant(of: cell(item), matching: find.text(item.text));

  // Actions

  Future showScreen() async {
    await tester.pumpWidget(ready(
      HomeScreen<StubSearchableItem>(
        container: container,
        searchItemBuilder: searchItemBuilder,
      ),
    ));
    await tester.pumpAndSettle();
  }

  // Expectations

  expectNoItemsMessageToBeShown() => expect(noItemsMessage, findsOneWidget);
  expectNoItemsMessageToBeHidden() => expect(noItemsMessage, findsNothing);

  Future expectItemCellsToBeShown() async {
    for (final item in container.searchableItems) {
      await Scrollable.ensureVisible(tester.element(cellText(item)));
      await tester.pump();
      expect(cellText(item), findsOneWidget);
    }
  }
}

class StubSearchableContainer with SearchableContainer<StubSearchableItem> {
  StubSearchableContainer(int count) : searchableItems = List.generate(count, (index) => StubSearchableItem(index));

  @override
  final List<StubSearchableItem> searchableItems;
}

class StubSearchableItem with SearchableItem {
  StubSearchableItem(this.index);

  final int index;

  String get text => index.toString();

  @override
  bool hitTest(String searchText) => text.contains(searchText);
}
