import 'package:robot_example/models/searchable_container.dart';
import 'package:robot_example/models/star.dart';

class StarList with SearchableContainer<Star> {
  StarList();

  // final List<Star> _stars = [];
  final List<Star> _stars = starRecords.map((record) => Star(name: record.name, magnitude: record.magnitude)).toList();

  int get length => _stars.length;

  Star getStar({required int index}) => _stars[index];

  @override
  List<Star> get searchableItems => _stars;
}

List<({String name, double magnitude})> starRecords = [
  (name: 'Sol', magnitude: -26.74),
  (name: 'Sirius', magnitude: -1.46),
  (name: 'Canopus', magnitude: -0.72),
  (name: 'Arcturus', magnitude: -0.04),
  (name: 'Alpha Centauri', magnitude: -0.01),
  (name: 'Vega', magnitude: 0.03),
  (name: 'Capella', magnitude: 0.08),
  (name: 'Rigel', magnitude: 0.12),
  (name: 'Procyon', magnitude: 0.38),
  (name: 'Achernar', magnitude: 0.46),
  (name: 'Betelgeuse', magnitude: 0.50),
  (name: 'Beta Centauri', magnitude: 0.61),
  (name: 'Altair', magnitude: 0.76),
  (name: 'Aldebaran', magnitude: 0.85),
  (name: 'Antares', magnitude: 0.96),
  (name: 'Spica', magnitude: 0.98),
  (name: 'Pollux', magnitude: 1.14),
  (name: 'Fomalhaut', magnitude: 1.16),
  (name: 'Deneb', magnitude: 1.25),
  (name: 'Mimosa', magnitude: 1.25),
  (name: 'Regulus', magnitude: 1.35),
  (name: 'Adhara', magnitude: 1.50),
  (name: 'Castor', magnitude: 1.58),
  (name: 'Gacrux', magnitude: 1.63),
  (name: 'Bellatrix', magnitude: 1.64),
  (name: 'Elnath', magnitude: 1.65),
  (name: 'Miaplacidus', magnitude: 1.67),
  (name: 'Alnilam', magnitude: 1.69),
  (name: 'Gamma Velorum', magnitude: 1.75),
  (name: 'Alnair', magnitude: 1.74),
  (name: 'Alioth', magnitude: 1.76),
  (name: 'Alnitak', magnitude: 1.77),
  (name: 'Mirfak', magnitude: 1.79),
  (name: 'Wezen', magnitude: 1.83),
  (name: 'Sargas', magnitude: 1.84),
  (name: 'Kaus Australis', magnitude: 1.85),
  (name: 'Avior', magnitude: 1.86),
  (name: 'Alkaid', magnitude: 1.86),
  (name: 'Menkalinan', magnitude: 1.90),
  (name: 'Alhena', magnitude: 1.93),
  (name: 'Peacock', magnitude: 1.94),
  (name: 'Algol', magnitude: 2.09),
  (name: 'Diphda', magnitude: 2.04),
  (name: 'Mizar', magnitude: 2.04),
  (name: 'Gienah', magnitude: 2.06),
  (name: 'Regor', magnitude: 2.08),
  (name: 'Nunki', magnitude: 2.05),
  (name: 'Albireo', magnitude: 3.05),
  (name: 'Alpheratz', magnitude: 2.06),
  (name: 'Mirach', magnitude: 2.05),
  (name: 'Algieba', magnitude: 2.08),
];
