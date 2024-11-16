import 'package:flutter/material.dart';

class Spbackground extends StatefulWidget {
  final Widget childWidget;
  const Spbackground({
    Key? key,
    required this.childWidget,
  }) : super(key: key);

  @override
  State<Spbackground> createState() => _SpbackgroundState();
}

class _SpbackgroundState extends State<Spbackground> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Container(
          decoration: BoxDecoration(),
          child: widget.childWidget,
        ),
      ),
    );
  }
}
