// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

//로컬 이미지 controller
class SpLottie1 extends StatefulWidget {
  final double? lottieWidth;
  final double? lottieHeight;
  final String lottiePath;
  final BoxFit lottieFit;

  const SpLottie1({
    Key? key,
    this.lottieWidth,
    this.lottieHeight,
    required this.lottiePath,
    required this.lottieFit,
  }) : super(key: key);

  @override
  State<SpLottie1> createState() => _SpLottie1State();
}

class _SpLottie1State extends State<SpLottie1> {
  @override
  Widget build(BuildContext context) {
    var lottie = Lottie.asset(widget.lottiePath);

    return SizedBox(
      width: widget.lottieWidth,
      height: widget.lottieHeight,
      child: lottie,
    );
  }
}
