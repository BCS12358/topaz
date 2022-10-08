import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:topaz/models/common/custom_icon.dart';

class CustomIconCollection {
  final List<CustomIcon> _icons = [
    CustomIcon(id: 'home', iconData: CupertinoIcons.home),
    CustomIcon(id: 'star', iconData: CupertinoIcons.star),
    CustomIcon(id: 'book_circle', iconData: CupertinoIcons.book_circle),
    CustomIcon(id: 'airplane', iconData: CupertinoIcons.airplane),
    CustomIcon(id: 'person', iconData: CupertinoIcons.person),
    CustomIcon(id: 'calendar', iconData: CupertinoIcons.calendar),
    CustomIcon(id: 'ant', iconData: CupertinoIcons.ant),
    CustomIcon(id: 'paintbrush', iconData: CupertinoIcons.paintbrush),
    CustomIcon(
        id: 'battery_charging', iconData: CupertinoIcons.battery_charging),
    CustomIcon(id: 'headphones', iconData: CupertinoIcons.headphones),
    CustomIcon(id: 'heart', iconData: CupertinoIcons.heart),
  ];

  UnmodifiableListView<CustomIcon> get icons => UnmodifiableListView(_icons);

  CustomIcon? findCustomItembyId(id) =>
      _icons.firstWhereOrNull((ci) => ci.id == id);
}
