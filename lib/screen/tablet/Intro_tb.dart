import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/common/utils.dart';
import 'package:sosang/constants/constants.dart';

class Intro_tb extends StatefulWidget {
  const Intro_tb({super.key});

  @override
  State<Intro_tb> createState() => _Intro_tbState();
}

class _Intro_tbState extends State<Intro_tb> {
  Size screenSize = ScreenUtil.screenSize;
  double desindeWidth = 448;
  double desindeHeight = 810;
  Color boxColor = SpColors.red;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(screenSize.width);
  }

  Widget btnWidget(String btnTitle, Color btnColor, Function() onBtnPressed) {
    return SpBtn(
      onBtnPressed: onBtnPressed,
      childWidget: Container(
        width: 204,
        height: 64,
        decoration: BoxDecoration(
            color: SpColors.white, borderRadius: BorderRadius.circular(10), border: Border.all(width: 2, color: SpColors.black)),
        child: Center(child: uiCommon.styledText(btnTitle, 16, 0, 1, FontWeight.w700, SpColors.black, TextAlign.center)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Spbackground(
        childWidget: Stack(
          children: [
            const SpImgBox1(imageWidth: double.infinity, imagePath: 'assets/img/intro_bg_tb.png', imageFit: BoxFit.fitWidth),
            Positioned(
                top: 230,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onDoubleTap: () {
                          uiCommon.SpMovePage(context, PAGE_LOGIN_TB_PAGE);
                          setState(() {});
                        },
                        child: SpImgBox1(
                          imagePath: 'assets/img/intro_logo.png',
                          imageFit: BoxFit.cover,
                          imageWidth: 488,
                        ),
                      ),
                      SpSpace(spaceWidth: 0, spaceHeight: 15),
                      SpImgBox1(
                        imagePath: 'assets/img/intro_text.png',
                        imageFit: BoxFit.cover,
                        imageWidth: 288,
                      ),
                      SpSpace(spaceWidth: 0, spaceHeight: 121),
                      Row(
                        children: [
                          Spacer(),
                          btnWidget('전체도면', SpColors.darkGray3, () {
                            GV.pStrg.putXXX(key_intro_value, 'regist');
                            uiCommon.SpMovePage(context, PAGE_FLOORPLAN_TB_PAGE);
                          }),
                          SpSpace(spaceWidth: 11, spaceHeight: 0),
                          btnWidget(
                            '도서검색',
                            SpColors.darkGreen,
                            () {
                              GV.pStrg.putXXX(key_intro_value, '');
                              uiCommon.SpMovePage(context, PAGE_BOOK_TB_PAGE);
                            },
                          ),
                          SpSpace(spaceWidth: 11, spaceHeight: 0),
                          btnWidget('사용방법', SpColors.textBoxHint, () {
                            GV.pStrg.putXXX(key_intro_value, '');
                            uiCommon.SpMovePage(context, PAGE_MANUAL_TB_PAGE);
                          }),
                          Spacer(),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
