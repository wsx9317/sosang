import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpContentTitle.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpInputWithLable.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/Sp_widget/SpToastMessage.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/constants/constants.dart';
import 'package:sosang/model/windowsOsk.dart';

class RegistKi extends StatefulWidget {
  const RegistKi({super.key});

  @override
  State<RegistKi> createState() => _RegistKiState();
}

class _RegistKiState extends State<RegistKi> {
  bool check = false;

  TextEditingController _textController1 = TextEditingController();
  TextEditingController _textController2 = TextEditingController();
  TextEditingController _textController3 = TextEditingController();
  TextEditingController _textController4 = TextEditingController();

  String userImgStr = GV.pStrg.getXXX(key_user_img_value);
  Uint8List? _imageData; // 추가된 코드
  String message = '';
  bool showToast = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageData = base64Decode(userImgStr);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();
    _textController4.dispose();
  }

  void validationCHeck() {
    debugPrint("check1 : ${_textController3.text}");
    String PhoneNum = _textController2.text;
    String birthday = '';
    String gender = '';

    if (_textController3.text.contains('-')) {
      birthday = _textController3.text.split('-')[0];
      gender = _textController3.text.split('-')[1];
    } else {
      birthday = _textController3.text;
      gender = _textController3.text;
    }

    // 전화번호 유효성 검사 함수
    bool isValidPhoneNumber(String number) {
      // 정규 표현식을 사용하여 숫자만 포함된 경우 true 반환
      RegExp regExp = RegExp(r'^[0-9]+$');
      return regExp.hasMatch(number);
    }

    debugPrint("check2 : ${isValidPhoneNumber(PhoneNum)}");

    if (_textController1.text.isEmpty || _textController1.text == '') {
      message = '이름을 입력해 주세요.';
      activeToast();
    } else if (_textController2.text.isEmpty || _textController2.text == '') {
      message = '핸드폰 번호를 입력해 주세요.';
      activeToast();
    } else if (!isValidPhoneNumber(PhoneNum)) {
      message = '핸드폰은 숫자로만 입력해 주세요.';
      activeToast();
    } else if (PhoneNum.length != 11) {
      message = '핸드폰 번호를 모두 입력해 주세요.';
      activeToast();
    } else if (_textController3.text.isEmpty || _textController3.text == '') {
      message = '생년월일6자리와 주민번호 뒤의 1자리를 입력해 주세요.';
      activeToast();
    } else if (!isValidPhoneNumber(birthday)) {
      message = '생년월일은 숫자로 입력해 주세요.';
      activeToast();
    } else if (!isValidPhoneNumber(gender)) {
      message = '성별은 숫자로만 표시해주세요.';
      activeToast();
    } else if (_textController3.text.length < 8) {
      message = '주민번호 앞 6자리와 뒤 1자리를 모두 입력해 주세요.';
      activeToast();
    } else if (_textController4.text.isEmpty || _textController4.text == '') {
      message = '확인코드를 입력해 주세요.';
      activeToast();
    } else {
      GV.pStrg.putXXX(key_user_name_value, _textController1.text);
      uiCommon.SpMovePage(context, PAGE_HOMEKI_PAGE);
    }
    setState(() {});
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
            childWidget: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  children: [
                    const SpSpace(spaceWidth: 0, spaceHeight: 60),
                    const SpcontentTitle(
                      pageTitle: '회원가입 정보입력',
                      padding: 24,
                      pageTitleSize: 72,
                    ),
                    const SpSpace(spaceWidth: 0, spaceHeight: 157),
                    SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: uiCommon.styledText("사진 촬영 완료!", 30, 0, 1, FontWeight.w700, SpColors.titleText, TextAlign.center),
                        )),
                    const SpSpace(spaceWidth: 0, spaceHeight: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 492,
                      child: Center(
                        child: (_imageData != null)
                            ? Image.memory(
                                _imageData!,
                                width: 390,
                                height: 492,
                                scale: 1,
                              )
                            : SizedBox(),
                      ),
                    ),
                    const SpSpace(spaceWidth: 0, spaceHeight: 80),
                    SpInputWithLable(
                      lable: '이름',
                      hint: "이름을 입력해주세요",
                      controller: _textController1,
                      keyboarType: 'text',
                      maxLength: 20,
                      editAble: true,
                      onTap: () {
                        WindowsOSK.show();
                      },
                    ),
                    SpInputWithLable(
                      lable: '핸드폰번호',
                      hint: "ex)01012345678",
                      controller: _textController2,
                      keyboarType: 'number2',
                      maxLength: 13,
                      editAble: true,
                      onTap: () {
                        WindowsOSK.show();
                      },
                    ),
                    SpInputWithLable(
                      lable: '생년월일(성별)',
                      hint: "ex)021017-1 형태로 입력해주세요",
                      controller: _textController3,
                      keyboarType: 'number3',
                      maxLength: 8,
                      editAble: true,
                      onTap: () {
                        WindowsOSK.show();
                      },
                    ),
                    SpInputWithLable(
                      lable: '확인코드',
                      hint: "숫자 4자리를 입력해주세요",
                      controller: _textController4,
                      keyboarType: 'number3',
                      maxLength: 4,
                      editAble: true,
                      onTap: () {
                        WindowsOSK.show();
                      },
                    ),
                    Row(
                      children: [
                        SpBtn(
                          onBtnPressed: () {
                            if (check) {
                              check = false;
                            } else {
                              check = true;
                            }
                            setState(() {});
                          },
                          childWidget: SpImgBox1(
                              imageWidth: 32,
                              imageHeight: 32,
                              imagePath: check ? 'assets/img/icon_checkbox_active.png' : 'assets/img/icon_checkbox_defualt.png',
                              imageFit: BoxFit.contain),
                        ),
                        const SpSpace(spaceWidth: 16, spaceHeight: 0),
                        uiCommon.styledText("개인 정보 수집 및 이용 동의", 28, 0, 1, FontWeight.w400, SpColors.darkGray2, TextAlign.left)
                      ],
                    ),
                    const SpSpace(spaceWidth: 0, spaceHeight: 80),
                    SpBtn(
                      onBtnPressed: check
                          ? () {
                              validationCHeck();
                            }
                          : () {},
                      childWidget: Container(
                        width: double.infinity,
                        height: 112,
                        decoration: BoxDecoration(
                          color: check ? SpColors.darkGray3 : SpColors.lightGray4,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: uiCommon.styledText("가입하기", 32, 0, 1, FontWeight.w700, SpColors.white, TextAlign.center),
                        ),
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
              child: SpToastMessage(message: message),
            ),
          )
        ],
      ),
    );
  }
}
