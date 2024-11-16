import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/model/variable.dart';

class Spgrid extends StatefulWidget {
  final Device device;
  final String bookTitle;
  final String bookType;
  final String bookWriter;
  const Spgrid({
    Key? key,
    required this.device,
    required this.bookTitle,
    required this.bookType,
    required this.bookWriter,
  }) : super(key: key);

  @override
  State<Spgrid> createState() => _SpgridState();
}

class _SpgridState extends State<Spgrid> {
  Widget badge() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: SpColors.orange,
      ),
      child: uiCommon.styledText('인기', (widget.device == Device.kiosk) ? 16 : 12, 0, (widget.device == Device.kiosk) ? 1.6 : 1.7,
          FontWeight.w700, SpColors.white, TextAlign.center),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 286,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all(width: 1, color: SpColors.lightGray3), borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Row(
              children: [
                badge(),
                SpSpace(spaceWidth: (widget.device == Device.kiosk) ? 12 : 7, spaceHeight: 0),
                uiCommon.styledText(
                    (widget.bookTitle.length > 5) ? "${widget.bookTitle.substring(0, 4)}..." : widget.bookTitle,
                    (widget.device == Device.kiosk) ? 32 : 15,
                    0,
                    (widget.device == Device.kiosk) ? 1.5 : 1.6,
                    FontWeight.w700,
                    SpColors.black,
                    TextAlign.center)
              ],
            ),
            SpSpace(spaceWidth: 0, spaceHeight: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                uiCommon.styledText(
                  widget.bookType,
                  (widget.device == Device.kiosk) ? 24 : 14,
                  0,
                  (widget.device == Device.kiosk) ? 1.5 : 1.6,
                  (widget.device == Device.kiosk) ? FontWeight.w400 : FontWeight.w500,
                  SpColors.textBoxHint,
                  TextAlign.center,
                ),
                uiCommon.styledText(
                    widget.bookWriter,
                    (widget.device == Device.kiosk) ? 24 : 14,
                    0,
                    (widget.device == Device.kiosk) ? 1.5 : 1.6,
                    (widget.device == Device.kiosk) ? FontWeight.w400 : FontWeight.w500,
                    SpColors.textBoxHint,
                    TextAlign.center),
              ],
            )
          ],
        ),
      ),
    );
  }
}
