import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/model/variable.dart';

class Sptab extends StatefulWidget {
  final int tabNum;
  final Device device;
  final List<String> btnTitleList;
  final List<Function()> onBtnPressedList;
  const Sptab({
    Key? key,
    required this.tabNum,
    required this.btnTitleList,
    required this.onBtnPressedList,
    required this.device,
  }) : super(key: key);

  @override
  State<Sptab> createState() => _SptabState();
}

class _SptabState extends State<Sptab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: SpColors.lightGray3,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            widget.btnTitleList.length,
            (index) => Row(
              children: [
                SpBtn(
                  onBtnPressed: widget.onBtnPressedList[index],
                  childWidget: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: (widget.tabNum == index)
                              ? (widget.device == Device.kiosk)
                                  ? 4
                                  : 2
                              : 0,
                          color: (widget.tabNum == index) ? SpColors.black : SpColors.invisiable,
                        ),
                      ),
                    ),
                    child: uiCommon.styledText(widget.btnTitleList[index], (widget.device == Device.kiosk) ? 40 : 16, 0, 2, FontWeight.w700,
                        (widget.tabNum == index) ? SpColors.titleText : SpColors.lightGray4, TextAlign.right),
                  ),
                ),
                SpSpace(spaceWidth: (widget.device == Device.kiosk) ? 32 : 24, spaceHeight: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
