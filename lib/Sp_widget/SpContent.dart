import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/common/uiCommon.dart';

class Spcontent extends StatefulWidget {
  final String pageTitle;
  final Widget subMenu;
  final Widget childWidget;
  final Function() recordBtn;
  const Spcontent({
    super.key,
    required this.pageTitle,
    required this.subMenu,
    required this.childWidget,
    required this.recordBtn,
  });

  @override
  State<Spcontent> createState() => _SpcontentState();
}

class _SpcontentState extends State<Spcontent> {
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
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              uiCommon.styledText(widget.pageTitle, 18, 0, 1, FontWeight.w700, SpColors.titleText, TextAlign.left),
              Spacer(),
              widget.subMenu
            ],
          ),
        ),
        SpSpace(spaceWidth: 0, spaceHeight: 16),
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 535,
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  color: SpColors.white,
                  border: Border.all(
                    width: 1,
                    color: SpColors.lightGray3,
                  ),
                ),
                child: Center(
                  child: widget.childWidget,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SpBtn(
                onBtnPressed: widget.recordBtn,
                childWidget: SpImgBox1(imageWidth: 69.47, imageHeight: 69.96, imagePath: "assets/img/icon_mic.png", imageFit: BoxFit.cover),
              ),
            )
          ],
        ),
        SpSpace(spaceWidth: 0, spaceHeight: 28),
      ],
    );
  }
}
