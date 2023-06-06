import 'package:flutter/material.dart';

typedef SearchItemsBuilder = Iterable<Widget> Function(BuildContext context, String searchText);

class SearchView extends StatelessWidget {
  const SearchView({
    super.key,
    required this.searchItemsBuilder,
  });

  final SearchItemsBuilder searchItemsBuilder;

  @override
  Widget build(BuildContext context) => SearchAnchor(
        isFullScreen: false,
        builder: (BuildContext context, SearchController controller) => IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => controller.openView(),
        ),
        suggestionsBuilder: (context, controller) => searchItemsBuilder(context, controller.text),
      );
}
