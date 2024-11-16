import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/common/uiCommon.dart';

const languages = [
  Language('한국어', 'ko_KR'),
  Language('English', 'en_US'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  String transcription = '';

  Language selectedLang = languages.first;

  @override
  void initState() {
    super.initState();
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
    });
  }

  void onRecognitionComplete(String text) {
    setState(() => _isListening = false);
  }

  void errorHandler() {
    debugPrint('에러 발생, 음성 인식기를 재시작합니다...');
    activateSpeechRecognizer(); // 에러 발생 시 인식기 재시작
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: uiCommon.styledText(
            transcription.isEmpty ? "무언가를 말해보세요..." : transcription,
            20,
            0,
            1,
            FontWeight.w600,
            SpColors.red,
            TextAlign.center,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _speechRecognitionAvailable && !_isListening
            ? () {
                _speech.listen().then((result) {
                  setState(() {
                    transcription = '';
                  });
                });
              }
            : null,
        child: Icon(_isListening ? Icons.stop : Icons.mic),
      ),
    );
  }
}
