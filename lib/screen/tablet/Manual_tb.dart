import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBottomModal.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpContentTitle.dart';
import 'package:sosang/Sp_widget/SpGrid.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpInputValidation.dart';
import 'package:sosang/Sp_widget/SpMenu.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/Sp_widget/SpSpeechToText.dart';
import 'package:sosang/Sp_widget/SpTab.dart';
import 'package:sosang/api/api.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/constants/constants.dart';
import 'package:sosang/model/variable.dart';
import 'package:sosang/modelVO/BookList.dart';
import 'package:sosang/modelVO/ChatBotModel.dart';

class Manual_tb extends StatefulWidget {
  const Manual_tb({super.key});

  @override
  State<Manual_tb> createState() => _BookState();
}

class _BookState extends State<Manual_tb> {
  bool showModal = false;
  bool showWifi = false;
  bool showSpeechToText = false;

  String sstStr = GV.pStrg.getXXX(key_sst_value);

  String imgType = '';
  String response = '';
  bool showChatbotText = false;

  @override
  void initState() {
    // TODO: implement initState
    GV.pStrg.putXXX(key_page_name, 'manual');
    super.initState();
    fetchData();
    if (sstStr != 'sstValue') {
      fetchData();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
      showChatbotText = true;
      debugPrint('showModal = $showModal');

      if (imgType == '와이파이 정보') {
        showModal = true;
        showWifi = true;
      } else if (imgType == '프로모션 정보') {
        showModal = true;
      } else if (imgType == '편의용품 정보') {
        uiCommon.SpMovePage(context, PAGE_FLOORPLAN_TB_PAGE);
      } else if (imgType == '화장실 정보') {
        uiCommon.SpMovePage(context, PAGE_FLOORPLAN_TB_PAGE);
      } else if (imgType == '자리 정보' || imgType == '콘센트 정보') {
        uiCommon.SpMovePage(context, PAGE_FLOORPLAN_TB_PAGE);
      }
    } else {
      response = '질문을 이해하지 못했습니다.';
      showModal = true;
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                    pageTitle: '이용안내',
                    pageTitleSize: 32,
                    padding: 16,
                    subMenu: Spmenu(
                      pageNum: 3,
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
                  const SpSpace(spaceWidth: 0, spaceHeight: 23),
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Stack(clipBehavior: Clip.none, children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 2, color: SpColors.black), borderRadius: BorderRadius.circular(8)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6.0),
                                  child: SpImgBox1(
                                    imagePath: 'assets/img/img_manual_bg_tb.png',
                                    imageFit: BoxFit.fitWidth,
                                    imageWidth: double.infinity,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 69,
                                left: -15,
                                child: SpImgBox1(
                                  imagePath: 'assets/img/img_rebon_tb.png',
                                  imageFit: BoxFit.cover,
                                  imageHeight: 64,
                                  imageWidth: 189,
                                ),
                              ),
                              Positioned(
                                  top: 150,
                                  left: 55,
                                  child: uiCommon.styledBorderText(
                                      '만화카페 100배 즐기기!', 56, 0, 1.5, FontWeight.w700, SpColors.white, TextAlign.start)),
                              Positioned(
                                  left: 55,
                                  top: 250,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 519,
                                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                        decoration: BoxDecoration(
                                            color: SpColors.white,
                                            border: Border.all(width: 2, color: SpColors.black),
                                            borderRadius: BorderRadius.circular(8)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            uiCommon.styledText('좌석 선택', 24, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.start),
                                            SpSpace(spaceWidth: 0, spaceHeight: 12),
                                            uiCommon.styledText(
                                                '- 원하는 좌석을 선택', 18, 0, 1.5, FontWeight.w400, SpColors.black, TextAlign.start),
                                            uiCommon.styledText(
                                                '- 음료 및 식사 주문(선택사항)', 18, 0, 1.5, FontWeight.w400, SpColors.black, TextAlign.start),
                                          ],
                                        ),
                                      ),
                                      SpSpace(spaceWidth: 0, spaceHeight: 7),
                                      Container(
                                        width: 519,
                                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                        decoration: BoxDecoration(
                                            color: SpColors.white,
                                            border: Border.all(width: 2, color: SpColors.black),
                                            borderRadius: BorderRadius.circular(8)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            uiCommon.styledText('챗봇 서비스', 24, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.start),
                                            SpSpace(spaceWidth: 0, spaceHeight: 12),
                                            uiCommon.styledText(
                                                '- 매장내 키오스크 태블릿으로 이용 가능', 18, 0, 1.5, FontWeight.w400, SpColors.black, TextAlign.start),
                                            uiCommon.styledText(
                                                '- 궁금한 내용 터치 후 문의', 18, 0, 1.5, FontWeight.w400, SpColors.black, TextAlign.start),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: showModal,
            child: Positioned(
                child: SpBottomModal(
              topValue: 100,
              paddingValue: 24,
              titleText: '매장안내',
              titleSize: 32,
              closeBtnWidth: 56,
              closeBtnHeight: 56,
              childWidget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Container(
                    color: SpColors.white,
                  )),
              btnOnPressed: () {
                if (showModal) {
                  showModal = false;
                } else {
                  showModal = true;
                }
                setState(() {});
              },
            )),
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
          Visibility(
              visible: showModal,
              child: Positioned(
                  child: SpBottomModal(
                      topValue: 100,
                      paddingValue: 24,
                      titleText: '',
                      titleSize: 32,
                      closeBtnWidth: 56,
                      closeBtnHeight: 56,
                      btnOnPressed: () {
                        if (showModal) {
                          showModal = false;
                        } else {
                          showModal = true;
                        }
                        setState(() {});
                      },
                      childWidget: Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Column(
                            children: [
                              uiCommon.styledText(response, 30, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                              SpSpace(spaceWidth: 0, spaceHeight: 80),
                              Visibility(
                                visible: showWifi,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(border: Border.all(width: 1, color: SpColors.textBoxHint)),
                                ),
                              )
                            ],
                          )))))
        ],
      ),
    );
  }
}
