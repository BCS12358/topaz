import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  final IconData iconData;
  final double size;
  final Color color;
  final int number;

  const NotificationIcon(
      {Key? key,
      required this.iconData,
      required this.size,
      required this.number,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      position: BadgePosition.topEnd(top: 2, end: 6),
      animationDuration: const Duration(milliseconds: 300),
      animationType: BadgeAnimationType.slide,
      badgeContent: Text(
        number.toString(),
        style: TextStyle(color: color),
      ),
      child:
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
    );
  }
}
