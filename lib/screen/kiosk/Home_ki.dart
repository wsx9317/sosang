import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpMenu.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/Sp_widget/SpToastMessage.dart';
import 'package:sosang/api/api.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/constants/constants.dart';
import 'package:sosang/model/variable.dart';
import 'package:sosang/modelVO/ChatBotModel.dart';

class HomeKi extends StatefulWidget {
  const HomeKi({super.key});

  @override
  State<HomeKi> createState() => _HomeKiState();
}

class _HomeKiState extends State<HomeKi> {
  String sstStr = GV.pStrg.getXXX(key_sst_value);
  bool showSpeechToText = false;
  String imgType = '';
  String response = '';
  bool showToast = false;
  String memberName = GV.pStrg.getXXX(key_user_name_value);
  String memberStatus = GV.pStrg.getXXX(key_intro_value);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GV.pStrg.putXXX(key_page_name, 'home');

    debugPrint('page : ${GV.pStrg.getXXX(key_intro_value)}');

    if (sstStr != "sstValue") {
      fetchData();
    }

    if (memberStatus == "regist") {
      response = '$memberName님 회원가입이 완료 되었습니다.';
      activeToast();
      GV.pStrg.putXXX(key_intro_value, "login");
      GV.pStrg.putXXX(key_user_name_value, "name");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> fetchData() async {
    ChatBotModel param = ChatBotModel(message: sstStr);
    final ChatBotModel? ret = await Api.mainChatBot(param);

    if (ret != null) {
      imgType = ret.intent!;
      if (imgType == '화장실 정보' || imgType == '자리 정보' || imgType == '콘센트 정보' || imgType == '편의용품 정보') {
        uiCommon.SpMovePage(context, PAGE_FLOORPLANKI_PAGE);
      } else if (imgType == '프로모션 정보' || imgType == '와이파이 정보') {
        uiCommon.SpMovePage(context, PAGE_MANUALKI_PAGE);
      }
    } else {
      response = '질문을 이해하지 못했습니다.';
      activeToast();
    }
  }

  void activeToast() async {
    showToast = true;
    // 3초 후에 showToast를 false로 설정
    await Future.delayed(Duration(seconds: 2), () {
      showToast = false; // showToast를 false로 설정
      // 여기서 setState를 호출하여 UI를 업데이트할 필요가 있습니다.
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Spbackground(
            childWidget: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    children: [
                      const SpSpace(spaceWidth: 0, spaceHeight: 60),
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 1227,
                            decoration: BoxDecoration(color: SpColors.lightGray3, borderRadius: BorderRadius.circular(24)),
                            //TODO 임시 이미지
                            child: SpImgBox1(imageHeight: 1227, imagePath: 'assets/img/img_home_back.png', imageFit: BoxFit.fitHeight),
                          ),
                          Positioned(
                            top: 24,
                            left: 0,
                            right: 0,
                            child: SizedBox(
                              child: Center(
                                child: SpBtn(
                                  onBtnPressed: () {
                                    uiCommon.SpMovePage(context, PAGE_INTRO_PAGE);
                                  },
                                  childWidget: Container(
                                    padding: EdgeInsets.symmetric(vertical:12, horizontal:32  ),
                                    decoration: BoxDecoration(
                                      color: SpColors.black,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: uiCommon.styledText("첫 화면으로 이동", 32, 1, 0, FontWeight.w700, SpColors.white, TextAlign.center),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 555,
                  left: 0,
                  right: 0,
                  child: Visibility(
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                gradient: const LinearGradient(
                                  colors: [SpColors.gradation9, SpColors.gradation10, SpColors.gradation11],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 22.5, vertical: 18),
                              child: uiCommon.styledText(
                                  '버튼을 클릭하면 음성으로 검색할 수 있습니다.', 24, 0, 1, FontWeight.w700, SpColors.white, TextAlign.center)),
                          CustomPaint(
                            size: Size(35, 20),
                            painter: TrianglePainter(),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 390,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: SpBtn(
                  onBtnPressed: () {
                    uiCommon.SpMovePage(context, PAGE_SST_PAGE);
                  },
                  childWidget:
                      const SpImgBox1(imageWidth: 160, imageHeight: 160, imagePath: "assets/img/icon_mic_ki.png", imageFit: BoxFit.cover),
                ),
              ),
            ),
          ),
          //하단메뉴
          const Positioned(
            bottom: 96,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 84),
                child: Spmenu(
                  pageNum: 0,
                  device: Device.kiosk,
                ),
              ),
            ),
          ),
          Visibility(
            visible: showToast,
            child: Positioned(
              left: 0,
              right: 0,
              bottom: 384,
              child: SpToastMessage(message: response),
            ),
          )
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = SpColors.skyblue2
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, size.height); // 삼각형의 아래 꼭지점
    path.lineTo(0, 0); // 왼쪽 위 꼭지점
    path.lineTo(size.width, 0); // 오른쪽 위 꼭지점
    path.close(); // 경로 닫기

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
