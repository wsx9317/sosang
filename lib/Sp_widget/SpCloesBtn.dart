import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';

class Spcloesbtn extends StatefulWidget {
  final Function() onBtnPressed;
  const Spcloesbtn({super.key, required this.onBtnPressed});

  @override
  State<Spcloesbtn> createState() => _SpcloesbtnState();
}

class _SpcloesbtnState extends State<Spcloesbtn> {
  @override
  Widget build(BuildContext context) {
    return SpBtn(
      onBtnPressed: widget.onBtnPressed,
      childWidget: const SpImgBox1(imageWidth: 0, imageHeight: 0, imagePath: "", imageFit: BoxFit.cover),
    );
  }
}
