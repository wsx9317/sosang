import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBottomModal.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/constants/constants.dart';

class SpKioskModal extends StatefulWidget {
  final String pageNm;
  final String modalTitle;
  final Function() cloesBtnFunction;
  final Function()? seatBtnFunction;
  final Function() completeFunction;
  final List<int> seatList;
  final List<String>? bookcaseKrList;
  final String? response;
  final List<String>? bookArea;
  final String completeBtnTitle;

  const SpKioskModal({
    super.key,
    required this.pageNm,
    required this.modalTitle,
    required this.cloesBtnFunction,
    this.seatBtnFunction,
    required this.completeFunction,
    this.bookcaseKrList,
    this.response,
    this.bookArea,
    required this.seatList,
    required this.completeBtnTitle,
  });

  @override
  State<SpKioskModal> createState() => _SpKioskModalState();
}

class _SpKioskModalState extends State<SpKioskModal> {
  int seatNum = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Color bookcaseColor(String bookcaseNm) {
    Color result = SpColors.white;
    List<String> items = [];

    for (String item in widget.bookcaseKrList!) {
      if (widget.bookArea!.contains(item)) {
        items.add(item);
        if (items.contains(bookcaseNm)) {
          result = SpColors.orange;
        }
      }
    }

    return result;
  }

  Widget seat(int setContentNum) {
    return GestureDetector(
      onTap: (widget.pageNm == 'Goods')
          ? () {
              seatNum = setContentNum;
              GV.pStrg.putXXX(key_seat_num, seatNum.toString());
              setState(() {});
            }
          : () {},
      child: Container(
        width: 144,
        height: 85,
        decoration: BoxDecoration(
          color: (seatNum == setContentNum)?SpColors.orange : SpColors.white,
          border: Border.all(width: 2, color: SpColors.black100Per),
        ),
        child: Center(
          child: uiCommon.styledText('좌석$setContentNum', 18, 0, 1, FontWeight.w700, SpColors.black, TextAlign.center),
        ),
      ),
    );
  }

  Widget seatColums(int seatNum1,int seatNum2, int seatNum3 ) {
    return Column(
      children: [
        seat(seatNum1),
        Container(width: 144, height: 16, color: SpColors.white,),
        seat(seatNum2),
        Container(width: 144, height: 16, color: SpColors.white,),
        seat(seatNum3),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SpBottomModal(
          topValue: 220,
          paddingValue: 60,
          titleText: widget.modalTitle,
          titleSize: 56,
          closeBtnHeight: 80,
          closeBtnWidth: 80,
          btnOnPressed: widget.cloesBtnFunction,
          childWidget: SizedBox(
            width: double.infinity,
            height: 1264,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      SpImgBox1(imageWidth: 920, imagePath: 'assets/img/img_store.png', imageFit: BoxFit.fitWidth),
                      Positioned(
                        top: 273,
                        left: 228,
                        child: SizedBox(
                            width: 464,
                            height: 287,
                            child: Row(
                              children: [
                                seatColums(1, 2, 3),
                                SpSpace(spaceWidth: 16, spaceHeight: 0),
                                seatColums(4, 5, 6),
                                SpSpace(spaceWidth: 16, spaceHeight: 0),
                                seatColums(7, 8, 9),
                              ],
                            )

                            // GridView.builder(
                            //   itemCount: 9, //item 개수
                            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            //     crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                            //     childAspectRatio: 144 / 85, //item 의 가로 1, 세로 2 의 비율
                            //     mainAxisSpacing: 16, //수평 Padding
                            //     crossAxisSpacing: 16, //수직 Padding
                            //   ),
                            //   itemBuilder: (BuildContext context, int index) {
                            //     //item 의 반목문 항목 형성
                            //     return GestureDetector(
                            //       onTap: (widget.pageNm == 'Goods')
                            //           ? (widget.seatList[index] == 1)
                            //               ? () {}
                            //               : () {
                            //                   seatNum = index + 1;
                            //                   GV.pStrg.putXXX(key_seat_num, seatNum.toString());
                            //                   setState(() {});
                            //                 }
                            //           : () {},
                            //       child: Container(
                            //         width: 144,
                            //         height: 85,
                            //         decoration: BoxDecoration(
                            //             border: Border.all(width: 2, color: SpColors.black100Per),
                            //             color: (widget.seatList[index] == 1)
                            //                 ? SpColors.pink
                            //                 : (seatNum == index + 1)
                            //                     ? SpColors.orange
                            //                     : SpColors.white),
                            //         child: Center(
                            //           child: Column(
                            //             mainAxisAlignment: MainAxisAlignment.center,
                            //             children: [
                            //               uiCommon.styledText(
                            //                   '좌석 ${index + 1}', 18, 0, 1.3, FontWeight.w700, SpColors.black, TextAlign.center),
                            //               Visibility(
                            //                 visible: (widget.seatList[index] == 1) ? true : false,
                            //                 child:
                            //                     uiCommon.styledText('(이용중)', 18, 0, 1.3, FontWeight.w700, SpColors.black, TextAlign.center),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // ),
                            ),
                      ),
                      Positioned(
                        top: 219,
                        right: 42,
                        child: (widget.bookArea != null)
                            ? SizedBox(
                                width: 92,
                                height: 383,
                                child: GridView.builder(
                                  itemCount: 7, //item 개수
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1, //1 개의 행에 보여줄 item 개수
                                    childAspectRatio: 92 / 53, //item 의 가로 1, 세로 2 의 비율
                                    mainAxisSpacing: 2, //수평 Padding
                                    crossAxisSpacing: 0, //수직 Padding
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    //item 의 반목문 항목 형성
                                    return Container(
                                      width: 92,
                                      height: 53,
                                      color: bookcaseColor((index + 1).toString()),
                                      child: Center(
                                        child: uiCommon.styledText(
                                            (index + 1).toString(), 18, 0, 1, FontWeight.w700, SpColors.black, TextAlign.center),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : const SizedBox(),
                      ),
                      Positioned(
                        bottom: 125,
                        left: 42,
                        child: (widget.bookArea != null)
                            ? SizedBox(
                                width: 92,
                                height: 286,
                                child: GridView.builder(
                                  itemCount: 4, //item 개수
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1, //1 개의 행에 보여줄 item 개수
                                    childAspectRatio: 92 / 70, //item 의 가로 1, 세로 2 의 비율
                                    mainAxisSpacing: 2, //수평 Padding
                                    crossAxisSpacing: 0, //수직 Padding
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    //item 의 반목문 항목 형성
                                    return Container(
                                      width: 92,
                                      height: 70,
                                      color: (index == 0)
                                          ? bookcaseColor('아동')
                                          : (index == 1)
                                              ? bookcaseColor('일반도서')
                                              : (index == 2)
                                                  ? bookcaseColor('웹툰')
                                                  : bookcaseColor('편의시설'),
                                      child: Center(
                                        child: uiCommon.styledText(
                                            (index == 0)
                                                ? '아동'
                                                : (index == 1)
                                                    ? '일반'
                                                    : (index == 2)
                                                        ? '웹툰'
                                                        : '편의시설',
                                            18,
                                            0,
                                            1,
                                            FontWeight.w700,
                                            SpColors.black,
                                            TextAlign.center),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox(),
                      ),
                    ],
                  ),
                  (widget.response != null)
                      ? Column(
                          children: [
                            SpSpace(spaceWidth: 0, spaceHeight: 60),
                            SizedBox(
                              width: 920,
                              child: uiCommon.styledText(
                                  widget.response!, 40, 0, 1.3, FontWeight.w700, SpColors.black100Per, TextAlign.center),
                            )
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: SpBtn(
            onBtnPressed: (widget.pageNm == 'Goods')
                ? (seatNum == 0)
                    ? () {}
                    : widget.completeFunction
                : widget.completeFunction,
            childWidget: Container(
              width: 960,
              height: 112,
              color: (widget.pageNm == 'Goods')
                  ? (seatNum == 0)
                      ? SpColors.darkGray2
                      : SpColors.black
                  : SpColors.black,
              child: Center(
                child: uiCommon.styledText(widget.completeBtnTitle, 32, 0, 1, FontWeight.w700, SpColors.white, TextAlign.center),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
