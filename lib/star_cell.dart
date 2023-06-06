import 'package:flutter/material.dart';
import 'package:robot_example/detail_screen.dart';

import 'models/star.dart';

class StarCell extends StatelessWidget {
  const StarCell({super.key, required this.star, required this.showMagnitude});

  final Star star;
  final bool showMagnitude;

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          title: Text(star.name),
          subtitle: showMagnitude ? Text(star.magnitude.toString()) : null,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(star: star))),
        ),
      );
}
