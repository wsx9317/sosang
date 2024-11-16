import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpContentTitle.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpInputValidation.dart';
import 'package:sosang/Sp_widget/SpInputWithLable.dart';
import 'package:sosang/Sp_widget/SpPageTitle.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/api/api.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';

import 'package:sosang/constants/constants.dart';
import 'package:sosang/modelVO/FaceRequestModel.dart';

import 'package:http/http.dart' as http;

class Login_tb extends StatefulWidget {
  const Login_tb({super.key});

  @override
  State<Login_tb> createState() => _Login_tbState();
}

class _Login_tbState extends State<Login_tb> {
  TextEditingController _controller = TextEditingController();
  bool check = false;
  bool invalidCheck = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateButtonColor);
    fetchData();
  }

  @override
  void dispose() {
    _controller.removeListener(_updateButtonColor);
    _controller.dispose();
    super.dispose();
  }

  void _updateButtonColor() {
    setState(() {
      check = _controller.text.length >= 4;
    });
  }

  Future<void> fetchData() async {
    check = _controller.text.length >= 4;
    setState(() {});
  }

  void validationCHeck() {
    if (_controller.text.isEmpty || _controller.text.length < 4) {
      print('문제1');
      invalidCheck = true;
    } else if (_controller.text == '1234') {
      uiCommon.SpMovePage(context, PAGE_ADMIN_TB_PAGE);
      check = true;
    } else {
      check = true;
      invalidCheck = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Spbackground(
          childWidget: Container(
            color: SpColors.white,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                SpSpace(spaceWidth: 0, spaceHeight: 60),
                SpcontentTitle(
                  pageTitle: '로그인',
                  padding: 16,
                  pageTitleSize: 32,
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
                SpSpace(spaceWidth: 0, spaceHeight: 100),
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: uiCommon.styledText(
                      '비밀번호를 입력해주세요.',
                      28,
                      0,
                      1,
                      FontWeight.w700,
                      SpColors.titleText,
                      TextAlign.center,
                    ),
                  ),
                ),
                SpSpace(spaceWidth: 0, spaceHeight: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 140),
                  child: SpInputValidation(
                    width: 400,
                    height: 40,
                    verticalPadding: 8,
                    horizontalPadding: 12,
                    inputColor: SpColors.white,
                    borderColor: invalidCheck ? SpColors.red : SpColors.textBoxBorder,
                    round: 8,
                    textAlign: 'start',
                    hintText: '비밀번호 4자리',
                    hintTextFontSize: 14,
                    hintTextfontWeight: FontWeight.w400,
                    hintTextFontColor: SpColors.textBoxHint,
                    keyboardType: 'password2',
                    showSearchIcon: true,
                    controller: _controller,
                    validationText: '',
                    validationVisible: false,
                    vlaidationCheck: false,
                    enabledBool: true,
                    maxLength: 4,
                  ),
                ),
                Visibility(
                    visible: invalidCheck,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 140),
                      child: Column(
                        children: [
                          SpSpace(spaceWidth: 0, spaceHeight: 10),
                          SizedBox(
                              width: 400,
                              child: uiCommon.styledText('비밀번호를 다시 확인해주세요.', 14, 0, 1.5, FontWeight.w500, SpColors.red, TextAlign.start)),
                        ],
                      ),
                    )),
                SpSpace(spaceWidth: 0, spaceHeight: 80),
                Center(
                  child: SpBtn(
                    onBtnPressed: () {
                      validationCHeck();
                    },
                    childWidget: Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: check ? SpColors.orange : SpColors.orange60per,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: uiCommon.styledText("로그인", 18, 0, 1, FontWeight.w700, SpColors.white, TextAlign.center),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
