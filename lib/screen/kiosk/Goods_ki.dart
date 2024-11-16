import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBottomModal.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpContentTitle.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpKioskModal.dart';
import 'package:sosang/Sp_widget/SpMenu.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/Sp_widget/SpSpeechToText.dart';
import 'package:sosang/Sp_widget/SpTab.dart';
import 'package:sosang/Sp_widget/SpToastMessage.dart';
import 'package:sosang/api/api.dart';
import 'package:sosang/apiserver/sstApi.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/constants/constants.dart';
import 'package:sosang/model/variable.dart';
import 'package:sosang/modelVO/ChatBotModel.dart';
import 'package:sosang/modelVO/FoodList.dart';
import 'package:sosang/modelVO/SalesList.dart';

class GoodsKi extends StatefulWidget {
  const GoodsKi({super.key});

  @override
  State<GoodsKi> createState() => _GoodsKiState();
}

class _GoodsKiState extends State<GoodsKi> {
  List<String> subMenuNmList = [];
  List<Function()> tabFunctionList = [];
  int submenuNum = 0;
  bool showSpeechToText = false;
  List<String> menuCodeList = [];
  List<String> menuImgList = [];
  List<String> menuNameList = [];
  List<int> priceList = [];
  //하단에 표시하기 위해서
  List<List> orderList = [];
  String itemCode = '';
  String sstStr = GV.pStrg.getXXX(key_sst_value);

  int totalCnt = 0;

  bool showModal = false;
  bool showToast = false;

  String toastMessage = '주문이 완료 되었습니다.';

//임시_ 자리 비어있는지 아닌지 확인용
  List<int> seatList = [0, 1, 1, 0, 0, 0, 0, 0, 1];

  final ScrollController scrollController1 = ScrollController();
  final ScrollController scrollController2 = ScrollController();

  //볶음밥, 덮밥, 라면 구분이 없어서 만든 변수
  List<String> riceCodeList = [
    "M-01",
    "M-02",
    "M-03",
    "M-04",
    "M-05",
    "M-06",
    "M-07",
    "M-08",
    "M-09",
    "M-10",
    "M-11",
  ];
  List<String> ramenCodeList = [
    "M-12",
    "M-13",
    "M-14",
    "M-15",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    onTabFunction();
    GV.pStrg.putXXX(key_page_name, 'menu');
    if (sstStr != 'sstValue') {
      fetchData2();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController1.dispose();
    scrollController2.dispose();
  }

  Future<void> fetchData() async {
    subMenuNmList = ['커피', '디카페인', '볶음밥&덮밥', '라면'];
    menuCodeList = [];
    menuNameList = [];
    menuImgList = [];
    priceList = [];
    final Foodlist? ret = await Api.getFood();

    if (ret != null) {
      for (var i = 0; i < ret.list!.length; i++) {
        if (ret.list![i].foodName != '') {
          if (submenuNum == 0) {
            if (ret.list![i].code!.contains("C")) {
              menuCodeList.add(ret.list![i].code!);
              menuNameList.add(ret.list![i].foodName!);
              menuImgList.add("menu_${ret.list![i].code}.png");
              priceList.add(3000);
            }
          } else if (submenuNum == 1) {
            if (ret.list![i].code!.contains("D")) {
              menuCodeList.add(ret.list![i].code!);
              menuNameList.add(ret.list![i].foodName!);
              menuImgList.add("menu_${ret.list![i].code}.png");
              priceList.add(3000);
            }
          } else if (submenuNum == 2) {
            if (riceCodeList.contains(ret.list![i].code!)) {
              menuCodeList.add(ret.list![i].code!);
              menuNameList.add(ret.list![i].foodName!);
              menuImgList.add("menu_${ret.list![i].code}.png");
              priceList.add(3000);
            }
          } else {
            if (ramenCodeList.contains(ret.list![i].code!)) {
              menuCodeList.add(ret.list![i].code!);
              menuNameList.add(ret.list![i].foodName!);
              menuImgList.add("menu_${ret.list![i].code}.png");
              priceList.add(3000);
            }
          }
        }
      }
    }

    setState(() {});
  }

  //챗봇
  Future<void> fetchData2() async {
    ChatBotModel param = ChatBotModel(message: sstStr);
    final ChatBotModel? ret = await Api.menuChatBot(param);
    bool orderComplete = false;
    if (ret != null) {
      toastMessage = ret.response!;
      for (var i = 0; i < ret.order_list!.length; i++) {
        orderList.add(['a', 'a', ret.order_list![i].product, ret.order_list![i].num]);
      }

      orderComplete = true;
      cancelOrder();
      activeToast();
    } else {
      orderComplete = false;
    }

    if (orderComplete) {}
  }

  void onTabFunction() {
    for (var i = 0; i < subMenuNmList.length; i++) {
      tabFunctionList.add(() {
        submenuNum = i;
        setState(() {});
        scrollToTop();
        fetchData();
      });
    }
  }

  void orderFunction(String code, String itemImg, String itemName, int cnt) {
    if (orderList.isEmpty) {
      orderList.add([code, itemImg, itemName, cnt]);
    } else {
      bool codeExists = false; // code 존재 여부를 추적하는 변수
      for (var i = 0; i < orderList.length; i++) {
        if (orderList[i][0].toString().contains(code)) {
          codeExists = true; // 코드가 발견됨
          plusOrder(code);
          break; // "code"가 발견되면 더 이상 검색할 필요 없음
        }
      }
      if (!codeExists) {
        // 코드가 발견되지 않은 경우에만 추가
        orderList.add([code, itemImg, itemName, cnt]);
      }
    }

    debugPrint('check :  $orderList');
    totalCnt = 0;
    for (var i = 0; i < orderList.length; i++) {
      totalCnt = int.parse((totalCnt + orderList[i][3]).toString());
    }

    setState(() {});
  }

  void plusOrder(String code) {
    int orderCnt = 0;
    totalCnt = 0;
    for (var i = 0; i < orderList.length; i++) {
      if (orderList[i][0] == code) {
        orderCnt = orderList[i][3];
        orderList[i][3] = orderCnt + 1;
        break;
      }
    }
    for (var i = 0; i < orderList.length; i++) {
      totalCnt = int.parse((totalCnt + orderList[i][3]).toString());
    }

    setState(() {});
  }

  void minusOrder(String code) {
    int orderCnt = 0;
    totalCnt = 0;
    for (var i = 0; i < orderList.length; i++) {
      if (orderList[i][0] == code) {
        orderCnt = orderList[i][3];
        orderList[i][3] = orderCnt - 1;
        if (orderList[i][3] == 0) {
          orderList.removeWhere((item) => item[0] == code);
        }
        break;
      }
    }
    for (var i = 0; i < orderList.length; i++) {
      totalCnt = int.parse((totalCnt + orderList[i][3]).toString());
    }

    setState(() {});
  }

  void removeOrder(String code) {
    orderList.removeWhere((item) => item[0] == code);
    if (orderList.isEmpty) {
      itemCode = '';
    }
    totalCnt = 0;
    for (var i = 0; i < orderList.length; i++) {
      totalCnt = int.parse((totalCnt + orderList[i][3]).toString());
    }
    setState(() {});
  }

  void cancelOrder() {
    orderList = [];
    itemCode = '';
    setState(() {});
  }

  void scrollLeft() {
    scrollController2.animateTo(
      scrollController2.offset - 136,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void scrollRight() {
    scrollController2.animateTo(
      scrollController2.offset + 136,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void activeToast() async {
    print('hellow world');
    showToast = true;
    // 3초 후에 showToast를 false로 설정
    await Future.delayed(Duration(seconds: 2), () {
      showToast = false; // showToast를 false로 설정
      // 여기서 setState를 호출하여 UI를 업데이트할 필요가 있습니다.
    });
    setState(() {});
  }

  void scrollToTop() {
    scrollController1.jumpTo(0);
  }

  void showPage() {
    showSpeechToText = false;
    setState(() {});
  }

  String priceFormat(int price) {
    String result = '';
    var f = NumberFormat('###,###,###,###');
    result = f.format(price);
    return result;
  }

//TODO 추후에 변경될곳
  Widget goodsWidth() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: (submenuNum == 0)
            ? SpColors.gradation1
            : (submenuNum == 1)
                ? SpColors.gradation4
                : SpColors.gradation7,
      ),
    );
  }

  Widget slideBtn(Function() onBtnPressed, String imagePath) {
    return SpBtn(
        onBtnPressed: onBtnPressed, childWidget: SpImgBox1(imageWidth: 48, imageHeight: 48, imagePath: imagePath, imageFit: BoxFit.cover));
  }

  Widget menuCntBtn(Function() onBtnPressed, String imagePath) {
    return SpBtn(
        onBtnPressed: onBtnPressed, childWidget: SpImgBox1(imageWidth: 40, imageHeight: 40, imagePath: imagePath, imageFit: BoxFit.cover));
  }

  Widget selectMenuList(int orderNum, String code, String itemImg, String itemName, int itemCnt) {
    return Row(
      children: [
        Stack(
          children: [
            SizedBox(
              width: 120,
              height: 216,
              child: Column(
                children: [
                  const SpSpace(spaceWidth: 0, spaceHeight: 15),
                  Container(
                    width: 120,
                    height: 106,
                    decoration: BoxDecoration(color: SpColors.lightGray3, borderRadius: BorderRadius.circular(8)),
                    child: SpImgBox1(imageHeight: 106, imagePath: 'assets/img/$itemImg', imageFit: BoxFit.fitHeight),
                  ),
                  const SpSpace(spaceWidth: 0, spaceHeight: 12),
                  uiCommon.styledText((itemName.length > 6) ? '${itemName.substring(0, 6)}...' : itemName, 18, 0, 1, FontWeight.w700,
                      SpColors.black, TextAlign.center),
                  const SpSpace(spaceWidth: 0, spaceHeight: 16),
                  SizedBox(
                    width: 120,
                    height: 40,
                    child: Row(
                      children: [
                        menuCntBtn(() {
                          minusOrder(code);
                        }, "assets/img/icon_minus_btn.png"),
                        SizedBox(
                            width: 40, child: uiCommon.styledText("$itemCnt", 18, 0, 1, FontWeight.w700, SpColors.black, TextAlign.center)),
                        menuCntBtn(() {
                          plusOrder(code);
                        }, "assets/img/icon_plus_btn.png"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: SpBtn(
                onBtnPressed: () {
                  removeOrder(code);
                },
                childWidget:
                    SpImgBox1(imageWidth: 40, imageHeight: 40, imagePath: 'assets/img/icon_round_cloes.png', imageFit: BoxFit.cover),
              ),
            ),
          ],
        ),
        SpSpace(spaceWidth: ((orderList.length - 1) == orderNum) ? 0 : 16, spaceHeight: 0)
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
                    pageTitle: '메뉴',
                    padding: 12,
                    pageTitleSize: 72,
                    subMenu: SpBtn(
                      onBtnPressed: () {
                        uiCommon.SpMovePage(context, PAGE_HOMEKI_PAGE);
                      },
                      childWidget: SpImgBox1(imagePath: 'assets/img/icon_home.png', imageFit: BoxFit.cover),
                    ),
                  ),
                  const SpSpace(spaceWidth: 0, spaceHeight: 26),
                  //소메뉴
                  Sptab(tabNum: submenuNum, btnTitleList: subMenuNmList, onBtnPressedList: tabFunctionList, device: Device.kiosk),
                  const SpSpace(spaceWidth: 0, spaceHeight: 40),
                  //컨텐츠
                  SizedBox(
                    width: double.infinity,
                    height: 960,
                    child: Scrollbar(
                      controller: scrollController1,
                      thickness: 8,
                      radius: Radius.circular(16),
                      trackVisibility: false,
                      thumbVisibility: true,
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        controller: scrollController1,
                        itemCount: menuNameList.length, //item 개수
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                          childAspectRatio: 293.33 / 288, //item 의 가로 1, 세로 2 의 비율
                          mainAxisSpacing: 32, //수평 Padding
                          crossAxisSpacing: 32, //수직 Padding
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          //item 의 반목문 항목 형성
                          return GestureDetector(
                            onTap: () {
                              itemCode = menuCodeList[index];
                              setState(() {});
                              orderFunction(menuCodeList[index], menuImgList[index], menuNameList[index], 1);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Column(
                                children: [
                                  (menuImgList[index] != 'null')
                                      ? Container(
                                          height: 240,
                                          decoration: BoxDecoration(
                                            color: SpColors.lightGray3,
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(
                                                width: 2, color: (itemCode == menuCodeList[index]) ? SpColors.orange : SpColors.lightGray3),
                                          ),
                                          child: SpImgBox1(
                                              imageHeight: 240, imagePath: "assets/img/${menuImgList[index]}", imageFit: BoxFit.fitHeight),
                                        )
                                      : Container(
                                          height: 240,
                                          decoration: BoxDecoration(
                                            color: SpColors.lightGray3,
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                        ),
                                  const SpSpace(spaceWidth: 0, spaceHeight: 12),
                                  Row(
                                    children: [
                                      uiCommon.styledText(
                                          menuNameList[index], 24, 0, 1, FontWeight.w700, SpColors.titleText, TextAlign.left),
                                      const Spacer(),
                                      uiCommon.styledText(
                                          priceFormat(priceList[index]), 24, 0, 1, FontWeight.w700, SpColors.titleText, TextAlign.left)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (itemCode != '') ? true : false,
                    child: SizedBox(
                      width: double.infinity,
                      height: 240,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 523,
                            height: 216,
                            child: Row(
                              children: [
                                slideBtn(() {
                                  scrollLeft();
                                }, 'assets/img/icon_left_arrow.png'),
                                const SpSpace(spaceWidth: 16, spaceHeight: 0),
                                //주문한 메뉴 슬라이드되는 부분
                                SizedBox(
                                  width: 395,
                                  height: 240,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    controller: scrollController2,
                                    children: List.generate(
                                      orderList.length,
                                      (index) => selectMenuList(
                                        index,
                                        orderList[index][0],
                                        orderList[index][1],
                                        orderList[index][2],
                                        orderList[index][3],
                                      ),
                                    ),
                                  ),
                                ),
                                const SpSpace(spaceWidth: 16, spaceHeight: 0),
                                slideBtn(() {
                                  scrollRight();
                                }, 'assets/img/icon_right_arrow.png'),
                              ],
                            ),
                          ),
                          Spacer(),
                          Column(
                            children: [
                              const SpSpace(spaceWidth: 0, spaceHeight: 45.18),
                              SizedBox(
                                height: 174,
                                child: Row(
                                  children: [
                                    //가격, 수량
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SpSpace(spaceWidth: 0, spaceHeight: 35),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            uiCommon.styledText('주문수량', 24, 0, 1.3, FontWeight.w400, SpColors.black, TextAlign.center),
                                            const SpSpace(spaceWidth: 12, spaceHeight: 0),
                                            uiCommon.styledText('$totalCnt', 32, 0, 1.3, FontWeight.w700, SpColors.black, TextAlign.center),
                                          ],
                                        ),
                                        const SpSpace(spaceWidth: 0, spaceHeight: 8),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            uiCommon.styledText('합계금액', 24, 0, 1.3, FontWeight.w400, SpColors.black, TextAlign.center),
                                            SpSpace(spaceWidth: 12, spaceHeight: 0),
                                            uiCommon.styledText('${priceFormat((3000 * totalCnt))}원', 32, 0, 1.3, FontWeight.w700,
                                                SpColors.red2, TextAlign.center),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SpSpace(spaceWidth: 24, spaceHeight: 0),
                                    //버튼
                                    Column(
                                      children: [
                                        SpBtn(
                                          onBtnPressed: () {
                                            scrollToTop();
                                            showModal = true;
                                            setState(() {});
                                            //임시이동
                                            // uiCommon.SpMovePage(context, PAGE_LOGINKI_PAGE);
                                          },
                                          childWidget: Container(
                                            width: 154,
                                            height: 103,
                                            decoration: BoxDecoration(
                                              color: SpColors.orange,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child:
                                                  uiCommon.styledText('주문하기', 26, 0, 1, FontWeight.w700, SpColors.white, TextAlign.center),
                                            ),
                                          ),
                                        ),
                                        const SpSpace(spaceWidth: 0, spaceHeight: 8),
                                        SpBtn(
                                          onBtnPressed: () {
                                            cancelOrder();
                                          },
                                          childWidget: Container(
                                            width: 154,
                                            height: 63,
                                            decoration: BoxDecoration(
                                              color: SpColors.gray3,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child:
                                                  uiCommon.styledText('전체취소', 26, 0, 1, FontWeight.w700, SpColors.white, TextAlign.center),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
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
                  pageNum: 2,
                  device: Device.kiosk,
                ),
              ),
            ),
          ),
          //음성인식 버튼
          Visibility(
            visible: (itemCode == '') ? true : false,
            child: Positioned(
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
          ),
          //좌석선택 모달
          Visibility(
              visible: showModal,
              child: SpKioskModal(
                pageNm: 'Goods',
                modalTitle: '좌석을 선택해주세요.',
                cloesBtnFunction: () {
                  showModal = false;
                  setState(() {});
                },
                seatList: seatList,
                completeBtnTitle: '선택완료',
                completeFunction: () {
                  showModal = false;
                  submenuNum = 0;
                  toastMessage = '주문이 완료 되었습니다.';
                  setState(() {});
                  cancelOrder();
                  fetchData();
                  activeToast();
                },
              )),
          Visibility(
            visible: showToast,
            child: Positioned(
              left: 0,
              right: 0,
              bottom: 384,
              child: SpToastMessage(message: toastMessage),
            ),
          )
        ],
      ),
    );
  }
}
