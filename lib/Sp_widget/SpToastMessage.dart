import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/common/uiCommon.dart';

class SpToastMessage extends StatefulWidget {
  final String message;
  const SpToastMessage({super.key, required this.message});

  @override
  State<SpToastMessage> createState() => _SpToastMessageState();
}

class _SpToastMessageState extends State<SpToastMessage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(80), color: SpColors.orange),
        child: uiCommon.styledText(widget.message, 32, 0, 1, FontWeight.w400, SpColors.white, TextAlign.center),
      ),
    );
  }
}
