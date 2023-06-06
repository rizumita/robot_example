mixin SearchableContainer<Item extends SearchableItem> {
  List<Item> get searchableItems;

  List<Item> search(String searchText) {
    if (searchText.isEmpty) return [];
    return searchableItems.where((item) => item.hitTest(searchText)).toList();
  }
}

mixin SearchableItem {
  bool hitTest(String searchText);
}
