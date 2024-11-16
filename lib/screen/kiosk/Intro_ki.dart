import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBottomModal.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/common/utils.dart';
import 'package:sosang/constants/constants.dart';

class IntroKi extends StatefulWidget {
  const IntroKi({super.key});

  @override
  State<IntroKi> createState() => _IntroKiState();
}

class _IntroKiState extends State<IntroKi> {
  Size screenSize = ScreenUtil.screenSize;
  double desindeWidth = 448;
  double desindeHeight = 810;
  List<String> signList = ['-', '*'];
  bool showModal = false;

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
        width: 480,
        height: 112,
        decoration: BoxDecoration(
          color: btnColor,
          border: Border.all(width: 4, color: SpColors.black100Per),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: uiCommon.styledText(btnTitle, 35, 0, 1, FontWeight.w700, SpColors.black, TextAlign.center)),
      ),
    );
  }

  Widget contentTitleWidget(int contentNumm, String contentTitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        uiCommon.styledText('$contentNumm.', 26, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.left),
        SpSpace(spaceWidth: 7, spaceHeight: 0),
        uiCommon.styledText('$contentTitle', 26, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.left),
      ],
    );
  }

  Widget contentColumWidget(int signNum, String contentText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        uiCommon.styledText(
            signList[signNum], 24, 0, 1.5, FontWeight.w400, (signNum == 0) ? SpColors.black : SpColors.brown, TextAlign.left),
        uiCommon.styledText(contentText, 24, 0, 1.5, FontWeight.w400, (signNum == 0) ? SpColors.black : SpColors.brown, TextAlign.left),
      ],
    );
  }

  Widget contentsWidget(int contentNumm, String contentTitle, Widget contentWidgets) {
    return Stack(
      children: [
        Container(
          width: 274,
          height: 391,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
                color: SpColors.black100Per,
              ),
              color: SpColors.white),
        ),
        Positioned(
          top: 40,
          left: 24,
          right: 24,
          child: contentTitleWidget(contentNumm, contentTitle),
        ),
        Positioned(
          top: 134,
          left: 24,
          right: 24,
          child: contentWidgets,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Spbackground(
            childWidget: Stack(
              children: [
                const SpImgBox1(imageWidth: double.infinity, imagePath: 'assets/img/img_background.png', imageFit: BoxFit.fitWidth),
                Positioned(
                  bottom: 730,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      const SpSpace(spaceWidth: 0, spaceHeight: 270),
                      //버튼1
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Spacer(),
                            btnWidget(
                              '로그인',
                              SpColors.white,
                              () {
                                GV.pStrg.putXXX(key_intro_value, 'login');
                                uiCommon.SpMovePage(context, PAGE_LOGINKI_PAGE);
                              },
                            ),
                            const SpSpace(spaceWidth: 11, spaceHeight: 0),
                            btnWidget(
                              '비회원',
                              SpColors.white,
                              () {
                                GV.pStrg.putXXX(key_intro_value, 'noneMember');
                                uiCommon.SpMovePage(context, PAGE_HOMEKI_PAGE);
                              },
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      const SpSpace(spaceWidth: 0, spaceHeight: 24),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Spacer(),
                            btnWidget(
                              '회원가입',
                              SpColors.white,
                              () {
                                GV.pStrg.putXXX(key_intro_value, 'regist');
                                uiCommon.SpMovePage(context, PAGE_LOGINKI_PAGE);
                                // uiCommon.SpMovePage(context, PAGE_REGISTKI_PAGE);
                              },
                            ),
                            const SpSpace(spaceWidth: 11, spaceHeight: 0),
                            btnWidget(
                              '사용방법',
                              SpColors.white,
                              () {
                                showModal = true;
                                setState(() {});
                              },
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: showModal,
            child: Positioned(
              child: SpBottomModal(
                topValue: 220,
                paddingValue: 60,
                titleText: '사용방법',
                titleSize: 56,
                closeBtnHeight: 80,
                closeBtnWidth: 80,
                btnOnPressed: () {
                  if (showModal) {
                    showModal = false;
                  } else {
                    showModal = true;
                  }
                  setState(() {});
                },
                childWidget: Column(
                  children: [
                    SpSpace(spaceWidth: 0, spaceHeight: 60),
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: SpImgBox1(imageHeight: 1200, imagePath: "assets/img/img_manual_back.png", imageFit: BoxFit.fitHeight),
                          ),
                        ),
                        Positioned(
                            top: 98,
                            left: 40,
                            child:
                                SpImgBox1(imageHeight: 80, imageWidth: 345, imagePath: 'assets/img/img_rebon.png', imageFit: BoxFit.cover)),
                        Positioned(
                          top: 223,
                          left: 0,
                          right: 0,
                          child: uiCommon.styledBorderText('만화카페 100배 즐기기!', 72, 0, 1, FontWeight.w700, SpColors.white, TextAlign.center),
                        ),
                        Positioned(
                            top: 376,
                            left: 0,
                            right: 0,
                            child: Row(
                              children: [
                                Spacer(),
                                contentsWidget(
                                  1,
                                  '로그인/비회원/\n회원가입',
                                  Column(
                                    children: [
                                      contentColumWidget(0, ' 회원가입 후 로그인\n 진행 (얼굴인식, 확인\n 코드)'),
                                      contentColumWidget(0, ' 비회원도 이용 가능'),
                                      contentColumWidget(1, ' 비회원은 프로모션이\n 제공되지 않습니다.')
                                    ],
                                  ),
                                ),
                                SpSpace(spaceWidth: 12, spaceHeight: 0),
                                contentsWidget(
                                  2,
                                  '좌석 선택',
                                  Column(
                                    children: [
                                      contentColumWidget(0, ' 원하는 좌석을 선택'),
                                      contentColumWidget(0, ' 음료 및 식사 주문\n (선택사항)'),
                                    ],
                                  ),
                                ),
                                SpSpace(spaceWidth: 12, spaceHeight: 0),
                                contentsWidget(
                                  3,
                                  '챗봇 서비스',
                                  Column(
                                    children: [
                                      contentColumWidget(0, ' 매장내 키오스크 \n 태블릿으로 이용 가능'),
                                      contentColumWidget(0, ' 궁금한 내용 터치 후\n 문의')
                                    ],
                                  ),
                                ),
                                Spacer(),
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
