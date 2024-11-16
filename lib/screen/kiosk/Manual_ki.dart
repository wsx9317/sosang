import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBottomModal.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpContent.dart';
import 'package:sosang/Sp_widget/SpContentTitle.dart';
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

class ManualKi extends StatefulWidget {
  const ManualKi({super.key});

  @override
  State<ManualKi> createState() => _ManualKiState();
}

class _ManualKiState extends State<ManualKi> {
  bool showChatbotText = false;
  List<String> signList = ['-', '*'];

  String sstStr = GV.pStrg.getXXX(key_sst_value);

  String imgType = '';
  String response = '';

  bool showModal = false;
  bool showQR = false;
  bool showToast = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GV.pStrg.putXXX(key_page_name, 'manual');

    if (sstStr != 'sstValue') {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    showQR = false;
    showToast = false;

    ChatBotModel param = ChatBotModel(message: sstStr);

    final ChatBotModel? ret = await Api.mainChatBot(param);

    if (ret != null) {
      imgType = ret.intent!;
      response = ret.response!;

      if (imgType == '프로모션 정보') {
        showModal = true;
      } else if (imgType == '와이파이 정보') {
        showModal = true;
        showQR = true;
      } else if (imgType == '화장실 정보' || imgType == '자리 정보' || imgType == '콘센트 정보' || imgType == '편의용품 정보') {
        uiCommon.SpMovePage(context, PAGE_FLOORPLANKI_PAGE);
      } else {
        response = '질문을 이해하지 못했습니다.';
        activeToast();
      }
    } else {
      response = '질문을 이해하지 못했습니다.';
      activeToast();
    }
    setState(() {});
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
            childWidget: Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                children: [
                  const SpSpace(spaceWidth: 0, spaceHeight: 60),
                  SpcontentTitle(
                    pageTitle: '이용방법',
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
                      const SpImgBox1(imageWidth: double.infinity, imagePath: "assets/img/img_manual_back.png", imageFit: BoxFit.fitWidth),
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
                                  children: [contentColumWidget(0, ' 매장내 키오스크 \n 태블릿으로 이용 가능'), contentColumWidget(0, ' 궁금한 내용 터치 후\n 문의')],
                                ),
                              ),
                              Spacer(),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //리본
          const Positioned(
              top: 334,
              left: 40,
              child: SpImgBox1(imageHeight: 80, imageWidth: 345, imagePath: 'assets/img/img_rebon.png', imageFit: BoxFit.cover)),
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
                  pageNum: 4,
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
          Visibility(
            visible: showModal,
            child: SpBottomModal(
              topValue: 220,
              paddingValue: 60,
              titleText: "이용안내",
              titleSize: 56,
              closeBtnHeight: 80,
              closeBtnWidth: 80,
              btnOnPressed: () {
                showModal = false;
                setState(() {});
              },
              childWidget: SizedBox(
                width: double.infinity,
                height: 1264,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 700,
                        child: uiCommon.styledText(response, 40, 1, 0, FontWeight.w700, SpColors.black, TextAlign.center),
                      ),
                    ),
                    Visibility(
                      visible: showQR,
                      child: Column(
                        children: [
                          const SpSpace(spaceWidth: 0, spaceHeight: 50),
                          Container(
                            width: 300,
                            height: 300,
                            color: SpColors.black,
                          )
                        ],
                      ),
                    ),
                  ],
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
