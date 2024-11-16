import 'package:flutter/material.dart';

class SpSpace extends StatefulWidget {
  final double spaceWidth;
  final double spaceHeight;
  const SpSpace({super.key, required this.spaceWidth, required this.spaceHeight});

  @override
  State<SpSpace> createState() => _SpSpaceState();
}

class _SpSpaceState extends State<SpSpace> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = SizedBox(
      width: widget.spaceWidth,
      height: widget.spaceHeight,
    );
    return wg1;
  }
}
