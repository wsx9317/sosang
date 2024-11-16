import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpContent.dart';
import 'package:sosang/Sp_widget/SpContentTitle.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpMenu.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/Sp_widget/SpSpeechToText.dart';
import 'package:sosang/Sp_widget/SpSpeechToTextTb.dart';
import 'package:sosang/api/api.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/constants/constants.dart';
import 'package:sosang/model/variable.dart';
import 'package:sosang/modelVO/ChatBotModel.dart';

class FloorPlan_tb extends StatefulWidget {
  const FloorPlan_tb({super.key});

  @override
  State<FloorPlan_tb> createState() => _FloorPlan_tbState();
}

class _FloorPlan_tbState extends State<FloorPlan_tb> {
  List<String> subMenuNmList = [];
  int submenuNum = 0;
  List<String> floorPalnList = [];
  bool showSpeechToText = false;
  String sstStr = GV.pStrg.getXXX(key_sst_value);

  bool showToilet = false;
  bool showCircle = false;
  bool showGoods = false;

  List<bool> showFloorImg = [true, false];

  String imgType = '';
  String response = '';
  bool showChatbotText = false;

  @override
  void initState() {
    // TODO: implement initState
    GV.pStrg.putXXX(key_page_name, 'floor');
    super.initState();
    fetchData();
    debugPrint('$sstStr');
    if (sstStr != 'sstValue') {
      fetchData();
    }
  }

//임시
  Future<void> fetchData() async {
    debugPrint('check : $sstStr');

    ChatBotModel param = ChatBotModel(message: sstStr);

    final ChatBotModel? ret = await Api.mainChatBot(param);

    if (ret != null) {
      debugPrint('chatBot Check1 : ${ret.intent!}');
      debugPrint('chatBot Check1 : ${ret.response!}');
      imgType = ret.intent!;
      response = ret.response!;

      if (imgType == '화장실 정보') {
        showChatbotText = true;
        showToilet = true;
        showFloorImg = [true, false];
      } else if (imgType == '자리 정보' || imgType == '콘센트 정보') {
        showChatbotText = true;
        showFloorImg = [false, true];
        showCircle = true;
      } else if (imgType == '편의용품 정보') {
        showChatbotText = true;
        showFloorImg = [false, true];
        showGoods = true;
      } else if (imgType == '와이파이 정보') {
        uiCommon.SpMovePage(context, PAGE_MANUAL_TB_PAGE);
      } else if (imgType == '프로모션 정보') {
        uiCommon.SpMovePage(context, PAGE_MANUAL_TB_PAGE);
      }
    } else {
      response = '질문을 이해하지 못했습니다.';
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget floorPlan_tbImg() {
    return SpImgBox1(imageWidth: 829, imagePath: floorPalnList[submenuNum], imageFit: BoxFit.fitWidth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Spbackground(
          childWidget: Container(
            color: SpColors.white,
            padding: EdgeInsets.all(40),
            constraints: BoxConstraints(
              minWidth: 448,
            ),
            child: Column(
              children: [
                SpcontentTitle(
                  pageTitle: '전체도면',
                  pageTitleSize: 32,
                  padding: 16,
                  subMenu: Spmenu(
                    pageNum: 1,
                    device: Device.tablet,
                  ),
                  leftBtn: Row(
                    children: [
                      SpBtn(
                          onBtnPressed: () {
                            uiCommon.SpMovePage(context, PAGE_INTRO_TB_PAGE);
                          },
                          childWidget: SpImgBox1(imagePath: 'assets/img/back_btn.png', imageFit: BoxFit.cover)),
                      SpSpace(spaceWidth: 8, spaceHeight: 0)
                    ],
                  ),
                ),
                SpSpace(spaceWidth: 0, spaceHeight: 24),
                Expanded(
                    child: SizedBox(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: SpColors.textBoxBorder,
                          border: Border.all(
                            width: 1,
                            color: SpColors.lightGray3,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: showFloorImg[0],
                                child: Stack(children: [
                                  SpImgBox1(imageWidth: 829, imagePath: 'assets/img/img_floor_sample3.png', imageFit: BoxFit.fitWidth),
                                  Positioned(
                                      top: 0,
                                      left: 198,
                                      child: Container(
                                        width: 117,
                                        height: 171,
                                        decoration: BoxDecoration(
                                            color: showToilet ? SpColors.orange : SpColors.textBoxBorder,
                                            border: Border.all(width: 8, color: SpColors.black100Per)),
                                        child: Center(
                                          child: uiCommon.styledText('화장실', 14, 0, 1.6, FontWeight.w600, SpColors.black, TextAlign.center),
                                        ),
                                      )),
                                ]),
                              ),
                              Visibility(
                                visible: showFloorImg[1],
                                child: Stack(clipBehavior: Clip.none, children: [
                                  SpImgBox1(imageWidth: 700, imagePath: 'assets/img/img_store_default.png', imageFit: BoxFit.fitWidth),
                                  Visibility(
                                    visible: showCircle,
                                    child: Positioned(
                                      bottom: -25,
                                      left: 320,
                                      child: SpImgBox1(
                                          imageWidth: 60,
                                          imageHeight: 60,
                                          imagePath: 'assets/img/icon_position.png',
                                          imageFit: BoxFit.cover),
                                    ),
                                  ),
                                  Visibility(
                                    visible: showGoods,
                                    child: Positioned(
                                        bottom: 93,
                                        left: 57,
                                        child: Container(
                                            width: 85,
                                            height: 53,
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 1, color: SpColors.black),
                                              color: SpColors.orange,
                                            ),
                                            child: Center(
                                              child: uiCommon.styledText(
                                                  '편의시설', 16, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                                            ))),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                SpSpace(spaceWidth: 0, spaceHeight: 40),
                Visibility(
                  visible: showChatbotText,
                  child: Container(
                    child: uiCommon.styledText(response, 22, 0, 1, FontWeight.w700, SpColors.black, TextAlign.center),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 40,
          child: SpBtn(
            onBtnPressed: () {
              uiCommon.SpMovePage(context, PAGE_SST_TB_PAGE);
              setState(() {});
            },
            childWidget: SpImgBox1(imageWidth: 100, imageHeight: 100, imagePath: "assets/img/icon_mic.png", imageFit: BoxFit.cover),
          ),
        ),
        /* Visibility(
          visible: showSpeechToText,
          child: Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SpSpeechToTextTb(),
          ),
        ) */
      ]),
    );
  }
}
