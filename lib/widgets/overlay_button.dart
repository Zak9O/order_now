import 'package:flutter/material.dart';

class OverlayButton extends StatelessWidget {
  OverlayButton({
    @required this.icon,
    this.radius = 50.0,
    this.onTap,
  }) : assert(icon != null);

  final double radius;
  final Function onTap;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius * 2,
      width: radius * 2,
      child: Material(
        shape: CircleBorder(),
        color: Colors.black26,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: icon,
          ),
        ),
      ),
    );
  }
}
