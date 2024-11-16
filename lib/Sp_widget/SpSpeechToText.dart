import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/apiserver/sstApi.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';
import 'dart:async';

import 'package:sosang/constants/constants.dart';

class Spspeechtotext extends StatefulWidget {
  const Spspeechtotext({super.key});

  @override
  State<Spspeechtotext> createState() => _SpspeechtotextState();
}

class _SpspeechtotextState extends State<Spspeechtotext> {
  String sst = '말씀해 주세요.';
  StreamSubscription? _eventSubscription;

  @override
  void initState() {
    super.initState();
    sstApi();
  }

  Future<void> sstApi() async {
    try {
      // STT 시작 API 호출
      final httpClient = HttpClient();
      final request = await httpClient.getUrl(Uri.parse('http://localhost:5001/api/start-stt'));
      final response = await request.close();

      if (response.statusCode == 200) {
        print('STT 시작 API 호출 성공');
        // 응답 본문이 필요한 경우:
        // final responseBody = await response.transform(utf8.decoder).join();
        // print(responseBody);
      } else {
        print('STT 시작 API 호출 실패: ${response.statusCode}');
      }

      httpClient.close();
    } catch (e) {
      print('STT 시작 API 호출 중 오류 발생: $e');
    }

    String page = GV.pStrg.getXXX(key_page_name);
    print('check :  $page');

    // EventBus 리스너 설정
    GV.eventBus.on<String>().listen((event) {
      print('eventBus $event');
      //TODO 음성인식 결과가 날아온것을 처리하는 로직을 추가해야함.
      sst = event;
      if (mounted) {
        GV.pStrg.putXXX(key_sst_value, event);
        // sstFetchData(event, page);
        uiCommon.SpMovePage(context, '{PREV}');
      }
    });
  }

  @override
  void dispose() {
    _eventSubscription = null;
    _eventSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 기존 build 메서드 내용
    return Scaffold(
      body: Container(
        color: SpColors.black100Per,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 361,
              child: uiCommon.styledText(sst, 60, 0, 1, FontWeight.w700, SpColors.white, TextAlign.center),
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
            )
          ],
        ),
      ),
    );
  }
}
