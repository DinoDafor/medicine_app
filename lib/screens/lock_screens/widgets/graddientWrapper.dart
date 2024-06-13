import 'package:flutter/material.dart';

class GradientWrapper extends StatelessWidget {
  final Widget child;
  Color mainColor;

  GradientWrapper({required this.child, required this.mainColor});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: [
              Colors.green[800]!,
              Colors.green[500]!,
              Colors.green[400]!,
              Colors.green[300]!,
            ],
          ),
        ),
        child: this.child,
      ),
    );
  }
}
