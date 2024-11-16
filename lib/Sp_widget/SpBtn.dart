import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';

class SpBtn extends StatefulWidget {
  final Function()? onBtnPressed;
  final Widget childWidget;
  const SpBtn({super.key, this.onBtnPressed, required this.childWidget});

  @override
  State<SpBtn> createState() => _SpBtnState();
}

class _SpBtnState extends State<SpBtn> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = DeferredPointerHandler(
        child: DeferPointer(
            child: TextButton(
      onPressed: widget.onBtnPressed,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: widget.childWidget,
    )));
    return wg1;
  }
}
