import 'package:flutter/material.dart';

class Scafold extends StatelessWidget {
  Widget? child;
  Widget? bottomNavigationBar;
  Scafold({Widget? child, Widget? bottomNavigationBar}) {
    this.child = child;
    this.bottomNavigationBar = bottomNavigationBar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/bg_image.png",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: this.child,
          ),
        ],
      ),
    );
  }
}
