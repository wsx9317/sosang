import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/common/uiCommon.dart';

class SpPageTitle extends StatefulWidget {
  final String title;
  const SpPageTitle({super.key, required this.title});

  @override
  State<SpPageTitle> createState() => _SpPageTitleState();
}

class _SpPageTitleState extends State<SpPageTitle> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          uiCommon.styledText(widget.title, 48, 0, 1, FontWeight.w700, SpColors.black100Per, TextAlign.left),
        ],
      ),
    );
  }
}
