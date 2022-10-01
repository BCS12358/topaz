import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:topaz/models/common/custom_icon.dart';

class CustomIconCollection {
  final List<CustomIcon> _icons = [
    CustomIcon(id: 'star', iconData: CupertinoIcons.star),
    CustomIcon(id: 'book_circle', iconData: CupertinoIcons.book_circle),
    CustomIcon(id: 'airplane', iconData: CupertinoIcons.airplane),
    CustomIcon(id: 'person', iconData: CupertinoIcons.person),
    CustomIcon(id: 'calendar', iconData: CupertinoIcons.calendar),
    CustomIcon(id: 'ant', iconData: CupertinoIcons.ant),
    CustomIcon(id: 'paintbrush', iconData: CupertinoIcons.paintbrush),
  ];

  UnmodifiableListView<CustomIcon> get icons => UnmodifiableListView(_icons);

  CustomIcon? findCustomItembyId(id) =>
      _icons.firstWhereOrNull((ci) => ci.id == id);
}
