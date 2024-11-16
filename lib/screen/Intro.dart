import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/common/utils.dart';
import 'package:sosang/constants/constants.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  Size screenSize = ScreenUtil.screenSize;
  double desindeWidth = 448;
  double desindeHeight = 810;

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
        width: 139,
        height: 40,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
            child: uiCommon.styledText(btnTitle, 14, 0, 1, FontWeight.w700,
                SpColors.white, TextAlign.center)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Spbackground(
        childWidget: Stack(
          children: [
            const SpImgBox1(
                imageWidth: double.infinity,
                imagePath: 'assets/img/img_main_back.png',
                imageFit: BoxFit.fitWidth),
            Positioned(
              top: 77,
              right: 0,
              left: 0,
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Spacer(),
                    SpImgBox1(
                        imageWidth: 142,
                        imagePath: "assets/img/img_logo.png",
                        imageFit: BoxFit.fitWidth),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 110,
              right: 0,
              left: 0,
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Spacer(),
                    btnWidget('회원가입', SpColors.darkGray3, () {
                      GV.pStrg.putXXX(key_intro_value, 'regist');
                      uiCommon.SpMovePage(context, PAGE_LOGIN_PAGE);
                    }),
                    SpSpace(spaceWidth: 11, spaceHeight: 0),
                    btnWidget(
                      '로그인',
                      SpColors.darkGreen,
                      () {
                        GV.pStrg.putXXX(key_intro_value, 'login');
                        uiCommon.SpMovePage(context, PAGE_LOGIN_PAGE);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
