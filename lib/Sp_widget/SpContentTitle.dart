import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/common/uiCommon.dart';

class SpcontentTitle extends StatefulWidget {
  final String pageTitle;
  final double padding;
  final double pageTitleSize;
  final Widget? subMenu;
  final Widget? leftBtn;
  final Widget? rigthBtn;

  const SpcontentTitle({
    super.key,
    required this.pageTitle,
    required this.pageTitleSize,
    this.subMenu,
    required this.padding,
    this.leftBtn,
    this.rigthBtn,
  });

  @override
  State<SpcontentTitle> createState() => _SpcontentTitleState();
}

class _SpcontentTitleState extends State<SpcontentTitle> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: widget.padding),
          child: Row(
            children: [
              Row(
                children: [
                  (widget.leftBtn != null)
                      ? widget.leftBtn!
                      : SizedBox(),
                  uiCommon.styledText(widget.pageTitle, widget.pageTitleSize, 0,
                      1, FontWeight.w700, SpColors.titleText, TextAlign.left),
                  (widget.rigthBtn != null)
                      ? widget.rigthBtn!
                      : SizedBox()
                ],
              ),
              Spacer(),
              widget.subMenu ?? SizedBox()
            ],
          ),
        ),
      ],
    );
  }
}
