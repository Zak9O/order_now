import 'package:flutter/material.dart';

class ElevatedCard extends StatelessWidget {
  ElevatedCard({
    this.child,
    this.height,
    this.width,
    this.color = Colors.white,
    this.elevation = 8.0,
    this.borderRadius = 25.0,
    this.padding = 20.0,
    this.border = const BorderSide(color: Colors.transparent, width: 0.0),
  });

  final Color color;
  final double elevation;
  final double borderRadius;
  final double padding;
  final Widget child;
  final BorderSide border;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        shape: RoundedRectangleBorder(
          side: border,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        color: color,
        elevation: elevation,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: child,
        ),
      ),
    );
  }
}
