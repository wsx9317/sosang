import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/Sp_widget/SpCloesBtn.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/model/variable.dart';

class SpBottomModal extends StatefulWidget {
  final double topValue;
  final double paddingValue;
  final String titleText;
  final double titleSize;
  final double closeBtnHeight;
  final double closeBtnWidth;
  final Function() btnOnPressed;
  final Widget childWidget;
  const SpBottomModal({
    required this.topValue,
    required this.paddingValue,
    required this.titleText,
    required this.titleSize,
    required this.closeBtnHeight,
    required this.closeBtnWidth,
    required this.btnOnPressed,
    required this.childWidget,
    Key? key,
  }) : super(key: key);

  @override
  State<SpBottomModal> createState() => _SpBottomModalState();
}

class _SpBottomModalState extends State<SpBottomModal> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: SpColors.black80Per,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
            top: widget.topValue,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: SpColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: widget.paddingValue, horizontal: 60),
                    child: Row(
                      children: [
                        uiCommon.styledText(widget.titleText, widget.titleSize, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.left),
                        Spacer(),
                        SpBtn(
                            onBtnPressed: widget.btnOnPressed,
                            childWidget: SpImgBox1(
                              imagePath: 'assets/img/icon_close.png',
                              imageFit: BoxFit.cover,
                              imageHeight: widget.closeBtnHeight,
                              imageWidth: widget.closeBtnWidth,
                            ))
                      ],
                    ),
                  ),
                  widget.childWidget
                ],
              ),
            ))
      ],
    );
  }
}
