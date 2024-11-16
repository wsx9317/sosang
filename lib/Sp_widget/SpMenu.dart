import 'package:flutter/material.dart';

import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/constants/constants.dart';
import 'package:sosang/model/variable.dart';

class Spmenu extends StatefulWidget {
  final Device device;
  final int pageNum;
  const Spmenu({
    Key? key,
    required this.pageNum,
    required this.device,
  }) : super(key: key);

  @override
  State<Spmenu> createState() => _SpmenuState();
}

class _SpmenuState extends State<Spmenu> {
  Widget tabletBtn(Function() onBtnPressed, int pageNum, String imgPath, String menuTitle) {
    return SpBtn(
        onBtnPressed: onBtnPressed,
        childWidget: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(width: 1, color: (widget.pageNum == pageNum) ? SpColors.invisiable : SpColors.textBoxBorder),
            /* boxShadow: [
              BoxShadow(
                  blurRadius: 24,
                  offset: Offset(0, 0),
                  color: (widget.pageNum == pageNum)
                      ? SpColors.black8Per
                      : SpColors.black12Per,
                  spreadRadius: 0),
            ], */
            color: (widget.pageNum == pageNum) ? SpColors.black : SpColors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpImgBox1(imageWidth: 20, imageHeight: 20, imagePath: imgPath, imageFit: BoxFit.cover),
              const SpSpace(
                spaceWidth: 8,
                spaceHeight: 0,
              ),
              uiCommon.styledText(
                  menuTitle, 14, 0, 1.6, FontWeight.w600, (widget.pageNum == pageNum) ? SpColors.white : SpColors.black, TextAlign.center)
            ],
          ),
        ));
  }

  Widget adminBtn(Function() onBtnPressed, int pageNum, String menuTitle) {
    return SpBtn(
        onBtnPressed: onBtnPressed,
        childWidget: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(width: 1, color: (widget.pageNum == pageNum) ? SpColors.invisiable : SpColors.textBoxBorder),
            color: (widget.pageNum == pageNum) ? SpColors.black : SpColors.white,
          ),
          child: uiCommon.styledText(
              menuTitle, 14, 0, 1.6, FontWeight.w600, (widget.pageNum == pageNum) ? SpColors.white : SpColors.black, TextAlign.center),
        ));
  }

  Widget kisokBtn(Function() onBtnPressed, int pageNum, String imgPath, String menuTitle) {
    return SpBtn(
        onBtnPressed: (widget.pageNum == pageNum) ? () {} : onBtnPressed,
        childWidget: Container(
          width: 210,
          height: 249,
          padding: EdgeInsets.symmetric(vertical: 26),
          decoration: BoxDecoration(
            color: (widget.pageNum == pageNum) ? SpColors.white : SpColors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                  blurRadius: 18,
                  offset: Offset(0, 0),
                  color: (widget.pageNum == pageNum) ? SpColors.black8Per : SpColors.black12Per,
                  spreadRadius: 0),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpImgBox1(imageWidth: 54, imageHeight: 54, imagePath: imgPath, imageFit: BoxFit.cover),
              const SpSpace(
                spaceWidth: 0,
                spaceHeight: 9,
              ),
              uiCommon.styledText(menuTitle, 36, 0, 1, FontWeight.w700, SpColors.titleText, TextAlign.center),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return (widget.device == Device.kiosk)
        ? Row(
            children: [
              kisokBtn(() {
                uiCommon.SpMovePage(context, PAGE_FLOORPLANKI_PAGE);
                GV.pStrg.putXXX(key_sst_value, 'sstValue');
              }, 1, 'assets/img/icon_note_ki.png', '전체도면'),
              Spacer(),
              kisokBtn(() {
                uiCommon.SpMovePage(context, PAGE_GOODSKI_PAGE);
                GV.pStrg.putXXX(key_sst_value, 'sstValue');
              }, 2, 'assets/img/icon_memo_ki.png', '메뉴'),
              Spacer(),
              kisokBtn(() {
                uiCommon.SpMovePage(context, PAGE_BOOKKI_PAGE);
                GV.pStrg.putXXX(key_sst_value, 'sstValue');
              }, 3, 'assets/img/icon_book_ki.png', '도서검색'),
              Spacer(),
              kisokBtn(() {
                uiCommon.SpMovePage(context, PAGE_MANUALKI_PAGE);
                GV.pStrg.putXXX(key_sst_value, 'sstValue');
              }, 4, 'assets/img/icon_index_ki.png', '사용방법'),
            ],
          )
        : (widget.device == Device.tablet)
            ? Row(
                children: [
                  tabletBtn(() {
                    uiCommon.SpMovePage(context, PAGE_FLOORPLAN_TB_PAGE);
                    GV.pStrg.putXXX(key_sst_value, 'sstValue');
                  }, 1, (widget.pageNum == 1) ? 'assets/img/icon_note_white.png' : 'assets/img/icon_note.png', '전체도면'),
                  SpSpace(
                    spaceWidth: 12,
                    spaceHeight: 0,
                  ),
                  tabletBtn(() {
                    uiCommon.SpMovePage(context, PAGE_BOOK_TB_PAGE);
                    GV.pStrg.putXXX(key_sst_value, 'sstValue');
                  }, 2, (widget.pageNum == 2) ? 'assets/img/icon_book_white.png' : 'assets/img/icon_book.png', '도서검색'),
                  SpSpace(
                    spaceWidth: 12,
                    spaceHeight: 0,
                  ),
                  tabletBtn(() {
                    uiCommon.SpMovePage(context, PAGE_MANUAL_TB_PAGE);
                    GV.pStrg.putXXX(key_sst_value, 'sstValue');
                  }, 3, (widget.pageNum == 3) ? 'assets/img/icon_index_white.png' : 'assets/img/icon_index.png', '이용안내'),
                ],
              )
            : Row(
                children: [
                  adminBtn(() {}, 1, '월간'),
                  SpSpace(
                    spaceWidth: 12,
                    spaceHeight: 0,
                  ),
                  adminBtn(() {}, 2, '주간'),
                  SpSpace(
                    spaceWidth: 12,
                    spaceHeight: 0,
                  ),
                  adminBtn(() {}, 3, '일간'),
                ],
              );
  }
}
