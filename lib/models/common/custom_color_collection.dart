import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:topaz/models/common/custom_color.dart';

class CustomColorCollection {
  final List<CustomColor> _colors = [
    CustomColor(id: 'amber', color: Colors.amber),
    CustomColor(id: 'blue', color: Colors.blue),
    CustomColor(id: 'pink', color: Colors.pink),
    CustomColor(id: 'green', color: Colors.green),
    CustomColor(id: 'indigo', color: Colors.indigo),
    CustomColor(id: 'purple', color: Colors.purple),
    CustomColor(id: 'grey', color: Colors.grey),
    CustomColor(id: 'brown', color: Colors.brown),
    CustomColor(id: 'orange', color: Colors.orange)
  ];

  UnmodifiableListView<CustomColor> get colors => UnmodifiableListView(_colors);

  CustomColor? findColorById(id) => _colors.firstWhereOrNull((c) => c.id == id);
}
