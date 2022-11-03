import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../main.dart';
import 'custom_navigator_bar.dart';

class CustomNavItem extends StatelessWidget {
  final String? icon;
  final int? id;
  final Function? setPage;

  const CustomNavItem({this.setPage, this.icon, this.id});

  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        currentIndex = id ?? 0;
        setPage!();
      },
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.teal,
        // Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: 15,
          backgroundColor: currentIndex == id
              ? Colors.white.withOpacity(0.9)
              : Colors.transparent,
          child: SvgPicture.asset(
            icon!,
            color: currentIndex == id
                ? Colors.black
                : Colors.white.withOpacity(0.9),
            height: 20,
            width: 20,
          ),
        ),
      ),
    );
  }
}
