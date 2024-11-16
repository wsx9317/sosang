import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpMenu.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/Sp_widget/SpSpeechToText.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/model/variable.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String sstStr = '';
  bool showSpeechToText = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                  padding: EdgeInsets.fromLTRB(32, 32, 32, 40),
                  constraints: BoxConstraints(
                    minWidth: 448,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 510,
                        decoration: BoxDecoration(color: SpColors.lightGray3),
                        child: uiCommon.styledText(
                            sstStr,
                            18,
                            0,
                            1,
                            FontWeight.w600,
                            SpColors.titleText,
                            TextAlign.center),
                      ),
                      SpSpace(
                        spaceWidth: 0,
                        spaceHeight: 128,
                      ),
                      Spmenu(
                        pageNum: 0,
                        device: Device.kiosk,
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 165,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      SizedBox(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      gradient: const LinearGradient(
                                        colors: [
                                          SpColors.gradation9,
                                          SpColors.gradation10,
                                          SpColors.gradation11
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: uiCommon.styledText(
                                        '버튼을 클릭하면 음성으로 검색할 수 있습니다.',
                                        12,
                                        0,
                                        1,
                                        FontWeight.w700,
                                        SpColors.white,
                                        TextAlign.center)),
                                CustomPaint(
                                  size: Size(14, 7),
                                  painter: TrianglePainter(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SpSpace(spaceWidth: 0, spaceHeight: 6),
                      SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: SpBtn(
                            onBtnPressed: () {
                              showSpeechToText = true;
                              setState(() {});
                            },
                            childWidget: SpImgBox1(
                                imageWidth: 69.47,
                                imageHeight: 69.96,
                                imagePath: "assets/img/icon_mic.png",
                                imageFit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
