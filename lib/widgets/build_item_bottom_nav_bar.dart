import 'package:flutter/material.dart';

import '../models/models.dart';

class BuildItem extends StatelessWidget {
  final NavigationItem item;
  final bool isSelected;
  const BuildItem({Key? key, required this.item, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: isSelected
            ? []
            : [
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5.0, -5.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                ),
                BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(5.0, 5.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                ),
              ],
        gradient: isSelected
            ? LinearGradient(colors: [
                Colors.grey.shade500,
                Colors.grey.shade400,
                Colors.grey.shade300,
                Colors.grey.shade200,
                Colors.grey.shade100,
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)
            : null,
      ),
      child: IconTheme(
        data: IconThemeData(
          size: 25.0,
          color: isSelected ? item.color : Colors.grey[800],
        ),
        child: item.icon,
      ),
    );
  }
}
