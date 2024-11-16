import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpContentTitle.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpMenu.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/api/api.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/constants/constants.dart';
import 'package:sosang/model/variable.dart';
import 'package:sosang/modelVO/ChatBotModel.dart';

class FloorPlanKi extends StatefulWidget {
  const FloorPlanKi({super.key});

  @override
  State<FloorPlanKi> createState() => _FloorPlanKiState();
}

class _FloorPlanKiState extends State<FloorPlanKi> {
  List<String> subMenuNmList = [];
  int submenuNum = 0;
  List<String> floorPalnList = [];
  bool showChatbotText = false;

  bool showToilet = false;
  bool showRestaurant = false;
  bool showPharmacy = false;
  bool showHospital = false;
  bool showBakery = false;
  bool showAnimal = false;

  bool showSpeechToText = false;

  String imgType = '';
  String response = '';
  String toastMessage = '';

  bool showOutSide = false;
  bool showInSide = false;
  bool showWallSocket = false;
  bool showAmenities = false;

  List<int> seatList = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  String sstStr = GV.pStrg.getXXX(key_sst_value);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GV.pStrg.putXXX(key_page_name, 'floor');

    showOutSide = true;
    showInSide = false;
    showWallSocket = false;
    showToilet = false;
    showAmenities = false;

    if (sstStr != 'sstValue') {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    showOutSide = false;
    showInSide = false;
    showWallSocket = false;
    showToilet = false;
    showAmenities = false;
    seatList = [0, 0, 0, 0, 0, 0, 0, 0, 0];

    ChatBotModel param = ChatBotModel(message: sstStr);

    final ChatBotModel? ret = await Api.mainChatBot(param);

    if (ret != null) {
      imgType = ret.intent!;
      response = ret.response!;
      showChatbotText = true;

      if (imgType == '화장실 정보') {
        showOutSide = true;
        showToilet = true;
      } else if (imgType == '자리 정보') {
        showInSide = true;
        String backResponseStr = response.split('창가 자리는 ')[1].replaceAll('입니다.', '');
        int space = backResponseStr.split('번 ').length - 1;

        for (var i = 0; i < space; i++) {
          int seatNum = int.parse(backResponseStr.split('번 ')[i]);
          seatList[seatNum - 1] = 1;
        }
      } else if (imgType == '콘센트 정보') {
        showInSide = true;
        showWallSocket = true;
      } else if (imgType == '편의용품 정보') {
        showInSide = true;
        showAmenities = true;
      } else if (imgType == '프로모션 정보' || imgType == '와이파이 정보') {
        uiCommon.SpMovePage(context, PAGE_MANUALKI_PAGE);
      }
    } else {
      response = '질문을 이해하지 못했습니다.';
    }

    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget floorPlanImg() {
    return SpImgBox1(imageWidth: double.infinity, imagePath: floorPalnList[submenuNum], imageFit: BoxFit.fitWidth);
  }

  Widget seatContentsWiget(int seatNum, int status) {
    return Container(
      width: 144,
      height: 85,
      decoration:
          BoxDecoration(color: (status == 0) ? Colors.white : SpColors.pink, border: Border.all(width: 2, color: SpColors.black100Per)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            uiCommon.styledText('좌석 $seatNum', 18, 0, 1, FontWeight.w700, SpColors.black, TextAlign.center),
            Visibility(
                visible: (imgType == '자리 예약') ? true : false,
                child: uiCommon.styledText('(이용중)', 18, 0, 1.3, FontWeight.w700, SpColors.black, TextAlign.center)),
          ],
        ),
      ),
    );
  }

  Widget seatWiget(int seatNum1, int seatStatus1, int seatNum2, int seatStatus2, int seatNum3, int seatStatus3) {
    return Column(
      children: [
        seatContentsWiget(seatNum1, seatStatus1),
        Container(
          width: 144,
          height: 16,
          color: SpColors.white,
        ),
        seatContentsWiget(seatNum2, seatStatus2),
        Container(
          width: 144,
          height: 16,
          color: SpColors.white,
        ),
        seatContentsWiget(seatNum3, seatStatus3),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Spbackground(
            childWidget: Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                children: [
                  const SpSpace(spaceWidth: 0, spaceHeight: 60),
                   SpcontentTitle(
                    pageTitle: '전체도면',
                    padding: 12,
                    pageTitleSize: 72,
                    subMenu: SpBtn(
                      onBtnPressed: () {
                        uiCommon.SpMovePage(context, PAGE_HOMEKI_PAGE);
                      },
                      childWidget: SpImgBox1(imagePath: 'assets/img/icon_home.png', imageFit: BoxFit.cover),
                    ),
                  ),
                  const SpSpace(spaceWidth: 0, spaceHeight: 56),
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 1250,
                        decoration: BoxDecoration(
                          color: SpColors.lightGray3,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: showOutSide,
                                child: Stack(
                                  children: [
                                    SpImgBox1(
                                        imageWidth: 829, imageHeight: 405, imagePath: 'assets/img/img_floor.png', imageFit: BoxFit.cover),
                                    //화장실
                                    Visibility(
                                      visible: showToilet,
                                      child: Positioned(
                                        top: 1,
                                        left: 198,
                                        child: Container(
                                          width: 115,
                                          height: 169,
                                          decoration: BoxDecoration(
                                            color: showToilet ? SpColors.orange : SpColors.lightGray3,
                                            border: Border.all(
                                              width: 7,
                                              color: SpColors.black100Per,
                                            ),
                                          ),
                                          child: Center(
                                            child: uiCommon.styledText('화장실', 18, 0, 1, FontWeight.w700, SpColors.black, TextAlign.center),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: showInSide,
                                child: Stack(
                                  children: [
                                    const SizedBox(
                                      width: 920,
                                      height: 722,
                                    ),
                                    const Positioned(
                                      top: 0,
                                      right: 0,
                                      left: 0,
                                      child: SpImgBox1(imageWidth: 920, imagePath: 'assets/img/img_store.png', imageFit: BoxFit.fitWidth),
                                    ),
                                    //좌석
                                    Positioned(
                                      top: 273,
                                      left: 228,
                                      child: SizedBox(
                                        width: 464,
                                        height: 287,
                                        child: Row(
                                          children: [
                                            seatWiget(1, seatList[0], 2, seatList[1], 3, seatList[2]),
                                            const SpSpace(spaceWidth: 16, spaceHeight: 0),
                                            seatWiget(4, seatList[3], 5, seatList[4], 6, seatList[5]),
                                            const SpSpace(spaceWidth: 16, spaceHeight: 0),
                                            seatWiget(7, seatList[6], 8, seatList[7], 9, seatList[8]),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: showAmenities,
                                      child: Positioned(
                                        left: 40,
                                        bottom: 159,
                                        child: Container(
                                          width: 96,
                                          height: 74,
                                          decoration: BoxDecoration(
                                            color: SpColors.pink,
                                            border: Border.all(width: 2, color: SpColors.black100Per),
                                          ),
                                          child: Center(
                                            child: uiCommon.styledText('편의시설', 18, 0, 1, FontWeight.w700, SpColors.black, TextAlign.center),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: showWallSocket,
                                      child: const Positioned(
                                        bottom: 0,
                                        left: 413,
                                        child: SpImgBox1(
                                            imageHeight: 94,
                                            imageWidth: 94,
                                            imagePath: 'assets/img/icon_point.png',
                                            imageFit: BoxFit.cover),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: showChatbotText,
                                child: Column(
                                  children: [
                                    const SpSpace(spaceWidth: 0, spaceHeight: 30),
                                    Center(
                                      child: SizedBox(
                                        width: 840,
                                        child: uiCommon.styledText(
                                            response, 40, 0, 1.3, FontWeight.w700, SpColors.black100Per, TextAlign.center),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //하단 메뉴
          const Positioned(
            bottom: 96,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 84),
                child: Spmenu(
                  pageNum: 1,
                  device: Device.kiosk,
                ),
              ),
            ),
          ),
          //음성인식 버튼
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
        ],
      ),
    );
  }
}
