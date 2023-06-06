import 'package:flutter/foundation.dart';
import 'package:robot_example/models/searchable_container.dart';

@immutable
class Star with SearchableItem {
  const Star({required this.name, required this.magnitude});

  final String name;
  final double magnitude;

  @override
  bool hitTest(String searchText) => name.contains(searchText) || magnitude.toString().contains(searchText);
}
