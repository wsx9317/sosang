import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBottomModal.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpContentTitle.dart';
import 'package:sosang/Sp_widget/SpGrid.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpInputValidation.dart';
import 'package:sosang/Sp_widget/SpLottie.dart';
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

class Book_tb extends StatefulWidget {
  const Book_tb({super.key});

  @override
  State<Book_tb> createState() => _BookState();
}

class _BookState extends State<Book_tb> {
  List<String> btnTitleList = [];
  List<Function()> btnFunctionList = [];
  int selectedIndex = 0;

  List<bool> tagList = [];
  List<String> bookTitleList = [];
  List<String> bookTypteList = [];
  List<String> writerList = [];
  List<String> areaList = [];

  int submenuNum = 0;
  TextEditingController controller = TextEditingController();
  bool showModal = false;
  bool showSpeechToText = false;
  List<String> floorNum = ['1', '2', '3'];
  List<String> floorName = ['아동', '일반', '웹툰'];
  String bookTitle = '아무';
  String bookArea = '';
  List<String> bookcaseKrList = ['1', '2', '3', '4', '5', '6', '7', '아동', '일반도서', '웹툰', '편의시설'];
  List<int> seatList = [0, 1, 1, 0, 0, 0, 0, 0, 1];

  bool showChatbot = false;

  String bookNum = '';
  String bookArea2 = '';

  String sstStr = GV.pStrg.getXXX(key_sst_value);
  String imgType = '';
  String response = '';

  List<String> bookAreaList = [];

  @override
  void initState() {
    // TODO: implement initState
    GV.pStrg.putXXX(key_page_name, 'book');
    super.initState();
    fetchData();
    btnFunction();
    debugPrint('sstStr = $sstStr');
    if (sstStr != 'sstValue') {
      fetchData2();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

//임시
  Future<void> fetchData() async {
    btnTitleList = ['전체', '베스트셀러', '신간메뉴', '코믹스', '웹툰', '성인만화', '일반도서', '아동도서'];
    tagList = [];
    bookTitleList = [];
    bookTypteList = [];
    writerList = [];
    areaList = [];
    final Booklist? ret = await Api.getBook();
    // final now = DateTime.now();
    // final formatter = DateFormat("yyyy-MM");
    // String today = formatter.format(now);

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
          if (areaList.contains('아동1')) {
            int index = areaList.indexOf('아동1');
            areaList[index] = areaList[index].replaceAll('1', '');
          }
        }
      }
    }

    setState(() {});
  }

  Future<void> fetchData2() async {
    ChatBotModel param = ChatBotModel(message: sstStr);
    debugPrint('sstStr = $sstStr');
    final ChatBotModel? ret2 = await Api.bookChatBot(param);

    debugPrint('ret2 = $ret2');
    if (ret2 != null) {
      response = ret2.response!;
      if (ret2.response!.contains('책이 없습니다.')) {
      } else {
        int space1Cnt = ret2.response!.split(' 책장').length;
        for (var i = 0; i < space1Cnt; i++) {
          String frontStr = ret2.response!.split(' 책장')[i];
          int space2Cnt = frontStr.split(' ').length;
          String responseBookArea = frontStr.split(' ')[space2Cnt - 1];
          debugPrint("check : $responseBookArea");
          bookTitle = sstStr;
          if (responseBookArea.contains('번')) {
            bookAreaList.add(responseBookArea.replaceAll('번', ''));
          } else {
            bookAreaList.add(responseBookArea);
          }
        }
        // bookArea.toSet().toList();
        List<String> setBookArea = [];
        bookAreaList.forEach((element) {
          if (!setBookArea.contains(element)) {
            setBookArea.add(element);
          }
        });
        bookAreaList = setBookArea;
        showChatbot = true;
        showModal = true;
      }
      if (mounted) {
        setState(() {});
      }
    } else {}
    debugPrint('data = $showModal');
  }

  Color bookcaseColor(String bookcaseNm) {
    Color result = SpColors.white;
    List<String> items = [];

    for (String item in bookcaseKrList) {
      if (bookAreaList.contains(item)) {
        items.add(item);
        if (items.contains(bookcaseNm)) {
          result = SpColors.orange;
        }
      }
    }

    return result;
  }

  bool checkBottomConsonant(String input) {
    debugPrint(input);
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

  void btnFunction() async {
    for (var i = 0; i < btnTitleList.length; i++) {
      btnFunctionList.add(() {
        selectedIndex = i;
        submenuNum = i;
        debugPrint("$submenuNum");
        setState(() {});
        fetchData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
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
                      pageTitle: '도서검색',
                      pageTitleSize: 32,
                      padding: 16,
                      subMenu: Spmenu(
                        pageNum: 2,
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
                    SpSpace(spaceWidth: 0, spaceHeight: 16),
                    Sptab(
                      tabNum: selectedIndex,
                      btnTitleList: btnTitleList,
                      device: Device.tablet,
                      onBtnPressedList: btnFunctionList,
                    ),
                    SpSpace(spaceWidth: 0, spaceHeight: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        uiCommon.styledText(
                            '총 ${bookTitleList.length}', 14, 0, 1.6, FontWeight.w500, SpColors.textBoxHint, TextAlign.center),
                        SpInputValidation(
                          width: 312,
                          height: 40,
                          verticalPadding: 8,
                          horizontalPadding: 39,
                          inputColor: SpColors.white,
                          borderColor: SpColors.textBoxBorder,
                          round: 8,
                          textAlign: 'start',
                          hintText: '도서검색',
                          inputWithIcon: Icon(
                            Icons.search,
                            size: 20,
                          ),
                          iconSize: 20,
                          iconVerticalSize: 8,
                          iconleftSize: 12,
                          hintTextFontSize: 14,
                          hintTextfontWeight: FontWeight.w400,
                          hintTextFontColor: SpColors.textBoxHint,
                          keyboardType: 'text',
                          showSearchIcon: true,
                          controller: controller,
                          validationText: '',
                          validationVisible: false,
                          vlaidationCheck: false,
                          enabledBool: true,
                          onChange: (p0) {
                            fetchData();
                          },
                        ),
                      ],
                    ),
                    SpSpace(spaceWidth: 0, spaceHeight: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 400,
                      child: (bookTitleList.isNotEmpty)
                          ? GridView.builder(
                              itemCount: bookTitleList.length, //item 개수
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4, //1 개의 행에 보여줄 item 개수
                                childAspectRatio: 286 / 92, //item 의 가로 1, 세로 2 의 비율
                                mainAxisSpacing: 16, //수평 Padding
                                crossAxisSpacing: 16, //수직 Padding
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                //item 의 반목문 항목 형성
                                return SpBtn(
                                  childWidget: Container(
                                    padding: EdgeInsets.all(16),
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
                                                        width: 37,
                                                        height: 24,
                                                        decoration:
                                                            BoxDecoration(color: SpColors.orange, borderRadius: BorderRadius.circular(2)),
                                                        child: Center(
                                                          child: uiCommon.styledText(
                                                              '인기', 12, 0, 1.7, FontWeight.w700, SpColors.white, TextAlign.center),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                                SpSpace(spaceWidth: tagList[index] ? 7 : 0, spaceHeight: 0),
                                              ],
                                            ),
                                            uiCommon.styledText(
                                                (bookTitleList[index].length > 17)
                                                    ? "${bookTitleList[index].substring(0, 16)}..."
                                                    : bookTitleList[index],
                                                15,
                                                0,
                                                1.6,
                                                FontWeight.w700,
                                                SpColors.titleText,
                                                TextAlign.left)
                                          ],
                                        ),
                                        SpSpace(spaceWidth: 0, spaceHeight: 4),
                                        Row(
                                          children: [
                                            uiCommon.styledText(
                                                bookTypteList[index], 14, 0, 1.6, FontWeight.w500, SpColors.textBoxHint, TextAlign.left),
                                            Spacer(),
                                            uiCommon.styledText(
                                                (writerList[index].length > 9)
                                                    ? "${writerList[index].substring(0, 8)}..."
                                                    : writerList[index],
                                                14,
                                                0,
                                                1.6,
                                                FontWeight.w500,
                                                SpColors.textBoxHint,
                                                TextAlign.left),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  onBtnPressed: () {
                                    bookAreaList = [];
                                    showModal = true;
                                    bookTitle = bookTitleList[index];
                                    bookArea = areaList[index];
                                    bookAreaList.add(bookArea);
                                    setState(() {});
                                  },
                                );
                              },
                            )
                          : Center(
                              child: uiCommon.styledText('검색된 내용이 없습니다.', 30, 0, 1, FontWeight.w700, SpColors.gray3, TextAlign.center),
                            ),
                    ),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 315,
                          padding: EdgeInsets.only(top: 80),
                          child: SizedBox(
                            height: 400,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: uiCommon.styledText(
                                  (showChatbot)
                                      ? response
                                      : (bookArea == '1' ||
                                              bookArea == '2' ||
                                              bookArea == '3' ||
                                              bookArea == '4' ||
                                              bookArea == '5' ||
                                              bookArea == '6' ||
                                              bookArea == '7')
                                          ? (checkBottomConsonant(bookTitle[bookTitle.length - 1]))
                                              ? '“$bookTitle은 $bookArea번 책장에 위치해 있습니다.”'
                                              : '“$bookTitle는 $bookArea번 책장에 위치해 있습니다.”'
                                          : (checkBottomConsonant(bookTitle[bookTitle.length - 1]))
                                              ? '“$bookTitle은 $bookArea 책장에 위치해 있습니다.”'
                                              : '“$bookTitle는 $bookArea 책장에 위치해 있습니다.”',
                                  24,
                                  0,
                                  1.5,
                                  FontWeight.w700,
                                  SpColors.black100Per,
                                  TextAlign.left),
                            ),
                          )),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Stack(
                          children: [
                            SpImgBox1(
                              imagePath: 'assets/img/img_store_default.png',
                              imageFit: BoxFit.fitWidth,
                              imageWidth: 782,
                            ),
                            Positioned(
                              top: 189,
                              left: 63,
                              child: Column(
                                children: [
                                  Container(
                                    width: 96,
                                    height: 58,
                                    decoration: BoxDecoration(
                                      color: bookcaseColor('아동'),
                                      border: Border(
                                        top: BorderSide(width: 2, color: SpColors.black),
                                        left: BorderSide(width: 2, color: SpColors.black),
                                        right: BorderSide(width: 2, color: SpColors.black),
                                      ),
                                    ),
                                    child: Center(
                                      child: uiCommon.styledText('아동', 18, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                                    ),
                                  ),
                                  Container(
                                    width: 96,
                                    height: 58,
                                    decoration: BoxDecoration(
                                      color: bookcaseColor('일반도서'),
                                      border: Border(
                                        top: BorderSide(width: 2, color: SpColors.black),
                                        left: BorderSide(width: 2, color: SpColors.black),
                                        right: BorderSide(width: 2, color: SpColors.black),
                                      ),
                                    ),
                                    child: Center(
                                      child: uiCommon.styledText('일반', 18, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                                    ),
                                  ),
                                  Container(
                                    width: 96,
                                    height: 58,
                                    decoration: BoxDecoration(
                                      color: bookcaseColor('웹툰'),
                                      border: Border(
                                        top: BorderSide(width: 2, color: SpColors.black),
                                        left: BorderSide(width: 2, color: SpColors.black),
                                        right: BorderSide(width: 2, color: SpColors.black),
                                      ),
                                    ),
                                    child: Center(
                                      child: uiCommon.styledText('웹툰', 18, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                                    ),
                                  ),
                                  Container(
                                    width: 96,
                                    height: 58,
                                    decoration: BoxDecoration(color: SpColors.white, border: Border.all(width: 2, color: SpColors.black)),
                                    child: Center(
                                      child: uiCommon.styledText('편의시설', 18, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            /* Positioned(
                                top: 190,
                                left: 199,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 126,
                                      height: 68,
                                      decoration: BoxDecoration(color: SpColors.pink, border: Border.all(width: 2, color: SpColors.black)),
                                      child: Center(
                                        child: uiCommon.styledText(
                                            '좌석 1 \n (이용중)', 18, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                                      ),
                                    ),
                                    SpSpace(spaceWidth: 0, spaceHeight: 13),
                                    Container(
                                      width: 126,
                                      height: 68,
                                      decoration: BoxDecoration(color: SpColors.pink, border: Border.all(width: 2, color: SpColors.black)),
                                      child: Center(
                                        child: uiCommon.styledText(
                                            '좌석 1 \n (이용중)', 18, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                                      ),
                                    ),
                                    SpSpace(spaceWidth: 0, spaceHeight: 14),
                                    Container(
                                      width: 126,
                                      height: 68,
                                      decoration: BoxDecoration(color: SpColors.pink, border: Border.all(width: 2, color: SpColors.black)),
                                      child: Center(
                                        child: uiCommon.styledText(
                                            '좌석 1 \n (이용중)', 18, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                                      ),
                                    ),
                                  ],
                                )), */
                            Positioned(
                              top: 162,
                              right: 43,
                              child: Column(
                                children: [
                                  Container(
                                    width: 96,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: bookcaseColor('1'),
                                      border: Border(
                                        top: BorderSide(width: 2, color: SpColors.black),
                                        left: BorderSide(width: 2, color: SpColors.black),
                                        right: BorderSide(width: 2, color: SpColors.black),
                                      ),
                                    ),
                                    child: Center(
                                      child: uiCommon.styledText('1', 18, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                                    ),
                                  ),
                                  Container(
                                    width: 96,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: bookcaseColor('2'),
                                      border: Border(
                                        top: BorderSide(width: 2, color: SpColors.black),
                                        left: BorderSide(width: 2, color: SpColors.black),
                                        right: BorderSide(width: 2, color: SpColors.black),
                                      ),
                                    ),
                                    child: Center(
                                      child: uiCommon.styledText('2', 18, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                                    ),
                                  ),
                                  Container(
                                    width: 96,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: bookcaseColor('3'),
                                      border: Border(
                                        top: BorderSide(width: 2, color: SpColors.black),
                                        left: BorderSide(width: 2, color: SpColors.black),
                                        right: BorderSide(width: 2, color: SpColors.black),
                                      ),
                                    ),
                                    child: Center(
                                      child: uiCommon.styledText('3', 18, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                                    ),
                                  ),
                                  Container(
                                    width: 96,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: bookcaseColor('4'),
                                      border: Border(
                                        top: BorderSide(width: 2, color: SpColors.black),
                                        left: BorderSide(width: 2, color: SpColors.black),
                                        right: BorderSide(width: 2, color: SpColors.black),
                                      ),
                                    ),
                                    child: Center(
                                      child: uiCommon.styledText('4', 18, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                                    ),
                                  ),
                                  Container(
                                    width: 96,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: bookcaseColor('5'),
                                      border: Border(
                                        top: BorderSide(width: 2, color: SpColors.black),
                                        left: BorderSide(width: 2, color: SpColors.black),
                                        right: BorderSide(width: 2, color: SpColors.black),
                                      ),
                                    ),
                                    child: Center(
                                      child: uiCommon.styledText('5', 18, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                                    ),
                                  ),
                                  Container(
                                    width: 96,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: bookcaseColor('6'),
                                      border: Border(
                                        top: BorderSide(width: 2, color: SpColors.black),
                                        left: BorderSide(width: 2, color: SpColors.black),
                                        right: BorderSide(width: 2, color: SpColors.black),
                                      ),
                                    ),
                                    child: Center(
                                      child: uiCommon.styledText('6', 18, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                                    ),
                                  ),
                                  Container(
                                    width: 96,
                                    height: 40,
                                    decoration:
                                        BoxDecoration(color: bookcaseColor('7'), border: Border.all(width: 2, color: SpColors.black)),
                                    child: Center(
                                      child: uiCommon.styledText('7', 18, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                btnOnPressed: () {
                  if (showModal || showChatbot) {
                    showModal = false;
                    showChatbot = false;
                  } else {
                    showModal = true;
                  }

                  setState(() {});
                },
              )),
            ),
            /* Visibility(
              visible: showSpeechToText,
              child: Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Spspeechtotext(
                  onSpeechDetected: (String text) {
                    setState(() {
                      showSpeechToText = false;
                      sstStr = text;
                    });
                  },
                ),
              ),
            ), */
          ],
        ),
      ),
    );
  }
}
