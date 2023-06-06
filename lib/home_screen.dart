import 'package:flutter/material.dart';
import 'package:robot_example/models/searchable_container.dart';
import 'package:robot_example/search_view.dart';

typedef SearchItemBuilder<Item> = Widget Function(BuildContext context, Item item, bool isForSearchResult);

class HomeScreen<Item extends SearchableItem> extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.container,
    required this.searchItemBuilder,
  });

  final SearchableContainer<Item> container;
  final SearchItemBuilder<Item> searchItemBuilder;

  bool get hasNoItems => container.searchableItems.isEmpty;

  @protected
  @visibleForTesting
  static final noItemsMessageKey = UniqueKey();

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: hasNoItems
            ? null
            : SearchView(
                searchItemsBuilder: (context, searchText) => container
                    .search(searchText)
                    .map((item) => searchItemBuilder(
                          context,
                          item,
                          true,
                        ))
                    .toList(),
              ),
        body: SafeArea(
          bottom: false,
          child: hasNoItems
              ? Center(key: noItemsMessageKey, child: const Text('アイテムがありません'))
              : ListView.builder(
                  itemCount: container.searchableItems.length,
                  itemBuilder: (context, index) => searchItemBuilder(
                        context,
                        container.searchableItems[index],
                        false,
                      )),
        ),
      );
}
