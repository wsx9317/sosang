// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

//로컬 이미지 controller
class SpImgBox1 extends StatefulWidget {
  final double? imageWidth;
  final double? imageHeight;
  final String imagePath;
  final BoxFit imageFit;

  const SpImgBox1({
    Key? key,
    this.imageWidth,
    this.imageHeight,
    required this.imagePath,
    required this.imageFit,
  }) : super(key: key);

  @override
  State<SpImgBox1> createState() => _SpImgBox1State();
}

class _SpImgBox1State extends State<SpImgBox1> {
  @override
  Widget build(BuildContext context) {
    var img = Image.asset(widget.imagePath, fit: widget.imageFit);

    return SizedBox(
      width: widget.imageWidth,
      height: widget.imageHeight,
      child: img,
    );
  }
}
