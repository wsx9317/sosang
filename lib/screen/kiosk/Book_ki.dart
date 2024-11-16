import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpContentTitle.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpInputValidation.dart';
import 'package:sosang/Sp_widget/SpKioskModal.dart';
import 'package:sosang/Sp_widget/SpMenu.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/Sp_widget/SpTab.dart';
import 'package:sosang/api/api.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/constants/constants.dart';
import 'package:sosang/model/variable.dart';
import 'package:sosang/model/windowsOsk.dart';
import 'package:sosang/modelVO/BookList.dart';
import 'package:sosang/modelVO/ChatBotModel.dart';

class BookKi extends StatefulWidget {
  const BookKi({super.key});

  @override
  State<BookKi> createState() => _BookKiState();
}

class _BookKiState extends State<BookKi> {
  List<String> subMenuNmList = [];
  List<Function()> tabOnBntFunctionList = [];
  List<bool> tagList = [];
  List<String> bookTitleList = [];
  List<String> bookTypteList = [];
  List<String> writerList = [];
  List<String> areaList = [];
  List<String> bookcaseKrList = ['1', '2', '3', '4', '5', '6', '7', '아동', '일반도서', '웹툰', '편의시설'];
  int submenuNum = 0;
  bool showModal = false;
  //임시_ 자리 비어있는지 아닌지 확인용
  List<int> seatList = [0, 1, 1, 0, 0, 0, 0, 0, 1];

  String response = '';

  String bookTitle = '';
  List<String> setBookArea = [];
  List<String> bookArea = [];

  bool showSpeechToText = false;
  String sstStr = GV.pStrg.getXXX(key_sst_value);

  TextEditingController controller = TextEditingController();

  final ScrollController scrollController = ScrollController();

  StreamSubscription<String>? _eventBusSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    tabFunction();
    GV.pStrg.putXXX(key_page_name, 'book');
    if (sstStr != 'sstValue') {
      fetchData2(sstStr);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _eventBusSubscription?.cancel();
    scrollController.dispose();
  }

//임시
  Future<void> fetchData() async {
    subMenuNmList = ['전체', '베스트셀러', '신간메뉴', '코믹스', '웹툰', '성인만화', '일반도서', '아동도서'];
    tagList = [];
    bookTitleList = [];
    bookTypteList = [];
    writerList = [];
    areaList = [];
    final Booklist? ret = await Api.getBook();
    if (ret != null) {
      for (var i = 0; i < ret.list!.length; i++) {
        if (ret.list![i].title!.contains(controller.text)) {
          if (submenuNum == 0) {
            if (ret.list![i].etc1 != '') {
              tagList.add(true);
            } else {
              tagList.add(false);
            }
            bookTitleList.add(ret.list![i].title!);
            bookTypteList.add(ret.list![i].type!);
            writerList.add(ret.list![i].writer!);
            areaList.add(ret.list![i].area1!);
          } else if (submenuNum == 1) {
            if (ret.list![i].etc1 != '') {
              tagList.add(true);
              bookTitleList.add(ret.list![i].title!);
              bookTypteList.add(ret.list![i].type!);
              writerList.add(ret.list![i].writer!);
              areaList.add(ret.list![i].area1!);
            }
          } else if (submenuNum == 2) {
            if (ret.list![i].registDateTime!.contains('2024-10')) {
              if (ret.list![i].etc1 != '') {
                tagList.add(true);
              } else {
                tagList.add(false);
              }

              bookTitleList.add(ret.list![i].title!);
              bookTypteList.add(ret.list![i].type!);
              writerList.add(ret.list![i].writer!);
              areaList.add(ret.list![i].area1!);
            }
          } else if (submenuNum == 3) {
            if (ret.list![i].type! == '코믹스') {
              if (ret.list![i].etc1 != '') {
                tagList.add(true);
              } else {
                tagList.add(false);
              }

              bookTitleList.add(ret.list![i].title!);
              bookTypteList.add(ret.list![i].type!);
              writerList.add(ret.list![i].writer!);
              areaList.add(ret.list![i].area1!);
            }
          } else if (submenuNum == 4) {
            if (ret.list![i].type! == '웹툰') {
              if (ret.list![i].etc1 != '') {
                tagList.add(true);
              } else {
                tagList.add(false);
              }

              bookTitleList.add(ret.list![i].title!);
              bookTypteList.add(ret.list![i].type!);
              writerList.add(ret.list![i].writer!);
              areaList.add(ret.list![i].area1!);
            }
          } else if (submenuNum == 5) {
            if (ret.list![i].type! == '성인만화') {
              if (ret.list![i].etc1 != '') {
                tagList.add(true);
              } else {
                tagList.add(false);
              }

              bookTitleList.add(ret.list![i].title!);
              bookTypteList.add(ret.list![i].type!);
              writerList.add(ret.list![i].writer!);
              areaList.add(ret.list![i].area1!);
            }
          } else if (submenuNum == 6) {
            if (ret.list![i].type! == '일반도서') {
              if (ret.list![i].etc1 != '') {
                tagList.add(true);
              } else {
                tagList.add(false);
              }

              bookTitleList.add(ret.list![i].title!);
              bookTypteList.add(ret.list![i].type!);
              writerList.add(ret.list![i].writer!);
              areaList.add(ret.list![i].area1!);
            }
          } else if (submenuNum == 7) {
            if (ret.list![i].type! == '아동도서') {
              if (ret.list![i].etc1 != '') {
                tagList.add(true);
              } else {
                tagList.add(false);
              }

              bookTitleList.add(ret.list![i].title!);
              bookTypteList.add(ret.list![i].type!);
              writerList.add(ret.list![i].writer!);
              areaList.add(ret.list![i].area1!);
            }
          }
        }
      }
    }
    setState(() {});
  }

  Future<void> fetchData2(String sstStr) async {
    ChatBotModel param = ChatBotModel(message: sstStr);
    final ChatBotModel? ret = await Api.bookChatBot(param);
    if (ret != null) {
      response = ret.response!;
      if (ret.response!.contains('책이 없습니다.')) {
      } else {
        int space1Cnt = ret.response!.split(' 책장').length;
        for (var i = 0; i < space1Cnt; i++) {
          String frontStr = ret.response!.split(' 책장')[i];
          int space2Cnt = frontStr.split(' ').length;
          String responseBookArea = frontStr.split(' ')[space2Cnt - 1];
          debugPrint("check : $responseBookArea");
          bookTitle = sstStr;
          if (responseBookArea.contains('번')) {
            bookArea.add(responseBookArea.replaceAll('번', ''));
          } else {
            bookArea.add(responseBookArea);
          }
        }
        // bookArea.toSet().toList();
        bookArea.forEach((element) {
          if (!setBookArea.contains(element)) {
            setBookArea.add(element);
          }
        });
        showModal = true;
      }
    } else {}
    setState(() {});
  }

  void tabFunction() {
    for (var i = 0; i < subMenuNmList.length; i++) {
      tabOnBntFunctionList.add(() {
        submenuNum = i;
        controller.text = '';
        setState(() {});
        fetchData();
      });
    }
  }

  void showPage() {
    showSpeechToText = false;
    setState(() {});
  }

  bool checkBottomConsonant(String input) {
    bool result = false;
    if (isKorean(input)) {
      result = ((input.runes.first - 0xAC00) / (28 * 21)) < 0 ? false : (((input.runes.first - 0xAC00) % 28 != 0) ? true : false);
    }
    return result;
  }

  bool isKorean(String input) {
    bool isKorean = false;
    int inputToUniCode = input.codeUnits[0];

    isKorean = (inputToUniCode >= 12593 && inputToUniCode <= 12643)
        ? true
        : (inputToUniCode >= 44032 && inputToUniCode <= 55203)
            ? true
            : false;

    return isKorean;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Spbackground(
            childWidget: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  children: [
                    const SpSpace(spaceWidth: 0, spaceHeight: 60),
                    SpcontentTitle(
                      pageTitle: '도서검색',
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
                    Sptab(
                      tabNum: submenuNum,
                      btnTitleList: subMenuNmList,
                      device: Device.kiosk,
                      onBtnPressedList: tabOnBntFunctionList,
                    ),
                    const SpSpace(spaceWidth: 0, spaceHeight: 56),
                    //검색어
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SpInputValidation(
                            width: 800,
                            height: 80,
                            horizontalPadding: 64,
                            verticalPadding: 22,
                            inputColor: SpColors.white,
                            borderColor: SpColors.textBoxBorder,
                            round: 12,
                            maxLength: 255,
                            textAlign: 'start',
                            controller: controller,
                            hintText: "도서검색",
                            inputWithIcon: Icon(
                              Icons.search,
                              size: 40,
                            ),
                            showSearchIcon: true,
                            iconSize: 40,
                            iconVerticalSize: 20,
                            iconleftSize: 16,
                            hintTextFontSize: 28,
                            hintTextfontWeight: FontWeight.w400,
                            hintTextFontColor: SpColors.textBoxHint,
                            keyboardType: 'text',
                            validationText: '',
                            validationVisible: false,
                            vlaidationCheck: false,
                            enabledBool: true,
                            onTap: () {
                              WindowsOSK.show();
                            },
                            onChange: (p0) {},
                          ),
                          Spacer(),
                          SpBtn(
                            onBtnPressed: () {
                              fetchData();
                            },
                            childWidget: Container(
                              width: 141,
                              height: 88,
                              decoration: BoxDecoration(
                                color: SpColors.titleText,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(child: uiCommon.styledText('검색', 26, 0, 1, FontWeight.w700, SpColors.white, TextAlign.center)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SpSpace(spaceWidth: 0, spaceHeight: 40),
                    //켄텐츠
                    SizedBox(
                      width: double.infinity,
                      height: 896,
                      child: (bookTitleList.isNotEmpty)
                          ? Scrollbar(
                              controller: scrollController,
                              thickness: 8,
                              radius: Radius.circular(16),
                              trackVisibility: false,
                              thumbVisibility: true,
                              child: GridView.builder(
                                controller: scrollController,
                                itemCount: bookTitleList.length, //item 개수
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                                  childAspectRatio: 472 / 136, //item 의 가로 1, 세로 2 의 비율
                                  mainAxisSpacing: 16, //수평 Padding
                                  crossAxisSpacing: 16, //수직 Padding
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  //item 의 반목문 항목 형성
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: GestureDetector(
                                      onTap: () {
                                        setBookArea = [];
                                        if (areaList[index] == '1' ||
                                            areaList[index] == '2' ||
                                            areaList[index] == '3' ||
                                            areaList[index] == '4' ||
                                            areaList[index] == '5' ||
                                            areaList[index] == '6' ||
                                            areaList[index] == '7') {
                                          if (checkBottomConsonant(bookTitleList[index][bookTitleList[index].length - 1])) {
                                            response = '${bookTitleList[index]}은 ${areaList[index]}번 책장에 있습니다.';
                                          } else {
                                            response = '${bookTitleList[index]}는 ${areaList[index]}번 책장에 있습니다.';
                                          }
                                        } else {
                                          if (checkBottomConsonant(bookTitleList[index][bookTitleList[index].length - 1])) {
                                            response = '${bookTitleList[index]}은 ${areaList[index]} 책장에 있습니다.';
                                          } else {
                                            response = '${bookTitleList[index]}는 ${areaList[index]} 책장에 있습니다.';
                                          }
                                        }
                                        if (areaList[index].contains('아동')) {
                                          setBookArea.add('아동');
                                        } else {
                                          setBookArea.add(areaList[index]);
                                        }
                                        // bookArea = areaList[index];
                                        WindowsOSK.close();
                                        showModal = true;
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(24),
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1, color: SpColors.lightGray3), borderRadius: BorderRadius.circular(8)),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    tagList[index]
                                                        ? Container(
                                                            width: 44,
                                                            height: 30,
                                                            color: SpColors.orange,
                                                            child: Center(
                                                              child: uiCommon.styledText(
                                                                  '인기', 16, 0, 1, FontWeight.w700, SpColors.white, TextAlign.center),
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                    SpSpace(spaceWidth: tagList[index] ? 12 : 0, spaceHeight: 0),
                                                  ],
                                                ),
                                                uiCommon.styledText(
                                                    (bookTitleList[index].length > 15)
                                                        ? "${bookTitleList[index].substring(0, 14)}..."
                                                        : bookTitleList[index],
                                                    32,
                                                    0,
                                                    1,
                                                    FontWeight.w700,
                                                    SpColors.titleText,
                                                    TextAlign.left)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                uiCommon.styledText(
                                                    bookTypteList[index], 24, 0, 1, FontWeight.w400, SpColors.textBoxHint, TextAlign.left),
                                                Spacer(),
                                                uiCommon.styledText(
                                                    (writerList[index].length > 7)
                                                        ? "${writerList[index].substring(0, 7)}..."
                                                        : writerList[index],
                                                    24,
                                                    0,
                                                    1,
                                                    FontWeight.w400,
                                                    SpColors.textBoxHint,
                                                    TextAlign.left),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: uiCommon.styledText('검색된 내용이 없습니다.', 30, 0, 1, FontWeight.w700, SpColors.gray3, TextAlign.center),
                            ),
                    ),
                    const SpSpace(spaceWidth: 0, spaceHeight: 213),
                  ],
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
                  pageNum: 3,
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
                    WindowsOSK.close();
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
            child: SpKioskModal(
                pageNm: 'Book',
                modalTitle: '도서 검색',
                cloesBtnFunction: () {
                  showModal = false;
                  setState(() {});
                },
                completeFunction: () {
                  showModal = false;
                  setState(() {});
                },
                seatList: [],
                response: response,
                bookArea: setBookArea,
                bookcaseKrList: bookcaseKrList,
                completeBtnTitle: '확인'),
          ),
        ],
      ),
    );
  }
}
