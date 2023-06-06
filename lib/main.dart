import 'package:flutter/material.dart';
import 'package:robot_example/home_screen.dart';
import 'package:robot_example/models/star_list.dart';
import 'package:robot_example/star_cell.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: HomeScreen(
          container: StarList(),
          searchItemBuilder: (context, item, isForSearchResult) => StarCell(
            star: item,
            showMagnitude: isForSearchResult,
          ),
        ),
      );
}
