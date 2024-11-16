import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/apiserver/sstApi.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';
import 'dart:async';

import 'package:sosang/constants/constants.dart';

const languages = [
  Language('한국어', 'ko_KR'),
  Language('English', 'en_US'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class SpSpeechToTextTb extends StatefulWidget {
  const SpSpeechToTextTb({super.key});

  @override
  State<SpSpeechToTextTb> createState() => _SpSpeechToTextTbState();
}

class _SpSpeechToTextTbState extends State<SpSpeechToTextTb> {
  late SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  String transcription = '';

  bool speechStart = false;

  Language selectedLang = languages.first;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      _handleButtonClick(); // Simulate the button click
      speechStart = true;
    });
    activateSpeechRecognizer();
  }

  @override
  void dispose() {
    if (_isListening) {
      _speech.stop(); // 음성 인식 중지
    }
    super.dispose();
  }

  void activateSpeechRecognizer() {
    _speech = SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.setErrorHandler(errorHandler);

    // 기본 언어 활성화
    _speech.activate(selectedLang.code).then((res) {
      _speechRecognitionAvailable = res;
      setState(() {});
    });
  }

  void onSpeechAvailability(bool result) => setState(() => _speechRecognitionAvailable = result);

  void onRecognitionStarted() {
    setState(() => _isListening = true);
  }

  void onRecognitionResult(String text) {
    setState(() {
      transcription = text;
      debugPrint('Check = $text'); // 디버그 출력
      GV.pStrg.putXXX(key_sst_value, transcription);
    });

    /* _speech.stop(); */
  }

  void onRecognitionComplete(String text) {
    setState(() => _isListening = false);
    String pageName = GV.pStrg.getXXX(key_page_name);
    setState(() {});
    if (pageName == 'floor') {
      uiCommon.SpMovePage(context, PAGE_FLOORPLAN_TB_PAGE);
    } else if (pageName == 'book') {
      uiCommon.SpMovePage(context, PAGE_BOOK_TB_PAGE);
    } else {
      uiCommon.SpMovePage(context, PAGE_MANUAL_TB_PAGE);
    }
  }

  void errorHandler() {
    debugPrint('에러 발생, 음성 인식기를 재시작합니다...');
    /* activateSpeechRecognizer(); // 에러 발생 시 인식기 재시작 */
    String pageName = GV.pStrg.getXXX(key_page_name);
    setState(() {});
    if (pageName == 'floor') {
      uiCommon.SpMovePage(context, PAGE_FLOORPLAN_TB_PAGE);
    } else if (pageName == 'book') {
      uiCommon.SpMovePage(context, PAGE_BOOK_TB_PAGE);
    } else {
      uiCommon.SpMovePage(context, PAGE_MANUAL_TB_PAGE);
    }
  }

  void _handleButtonClick() {
    if (_speechRecognitionAvailable && !_isListening) {
      _speech.listen().then((result) {
        setState(() {
          transcription = '';
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 기존 build 메서드 내용
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: SpColors.black100Per,
        child: Visibility(
          visible: speechStart,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 500,
                child: uiCommon.styledText(
                    transcription.isEmpty ? '무언가를 말해보세요...' : transcription, 50, 0, 1, FontWeight.w700, SpColors.white, TextAlign.center),
              ),
              const SpSpace(spaceWidth: 0, spaceHeight: 120),
              const Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SpImgBox1(imageHeight: 240, imagePath: 'assets/img/speech_ani.gif', imageFit: BoxFit.fitHeight),
                    Positioned(
                      left: -180,
                      child: SpImgBox1(imageHeight: 240, imagePath: 'assets/img/soundwave_left.png', imageFit: BoxFit.fitHeight),
                    ),
                    Positioned(
                      right: -185,
                      child: SpImgBox1(imageHeight: 240, imagePath: 'assets/img/soundwave_right.png', imageFit: BoxFit.fitHeight),
                    )
                  ],
                ),
              ),
              SpBtn(
                  onBtnPressed: () {
                    _handleButtonClick();
                  },
                  childWidget: Container(
                    color: SpColors.invisiable,
                    width: 1,
                    height: 1,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
