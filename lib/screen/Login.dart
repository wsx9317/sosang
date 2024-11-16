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
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/api/api.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';

import 'package:sosang/constants/constants.dart';
import 'package:sosang/modelVO/FaceRequestModel.dart';

import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  final List<CameraDescription> cameras;
  const Login({super.key, required this.cameras});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _cameraInfo = 'Unknown';
  int loginState = 0;
  int captureStatus = 0;
  //TODO 사용자가 어드민인지, 일반사용자인지 확인 필요
  int userType = 0;
  //TODO 송신단말 기기 정보 보내야함 지금은 임시 String
  String hostname = 'home';
  late CameraController controller;
  Uint8List? _imageData; // 추가된 코드
  int _cameraIndex = 0;
  int _cameraId = -1;
  Size? _previewSize;
  MediaSettings _mediaSettings = const MediaSettings(
    resolutionPreset: ResolutionPreset.low,
    fps: 15,
    videoBitrate: 200000,
    audioBitrate: 32000,
    enableAudio: true,
  );

  bool isDetecting = false;
  final player = AudioPlayer();
  String pageStatus = GV.pStrg.getXXX(key_intro_value);
  List<String> btnValue = ['regist', 'login'];

  StreamSubscription<CameraErrorEvent>? _errorStreamSubscription;
  StreamSubscription<CameraClosingEvent>? _cameraClosingStreamSubscription;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _errorStreamSubscription?.cancel();
    _errorStreamSubscription = null;
    _cameraClosingStreamSubscription?.cancel();
    _cameraClosingStreamSubscription = null;
    super.dispose();
  }

  Future<void> _fetchCameras() async {
    String cameraInfo;
    List<CameraDescription> cameras = <CameraDescription>[];

    int cameraIndex = 0;
    try {
      cameras = await CameraPlatform.instance.availableCameras();
      if (cameras.isEmpty) {
        cameraInfo = 'No available cameras';
      } else {
        cameraIndex = _cameraIndex % cameras.length;
        cameraInfo = 'Found camera: ${cameras[cameraIndex].name}';
      }
    } on PlatformException catch (e) {
      cameraInfo = 'Failed to get cameras: ${e.code}: ${e.message}';
    }

    if (mounted) {
      setState(() {
        _cameraIndex = cameraIndex;
        _cameraInfo = cameraInfo;
      });
    }
  }

  Future<void> _initializeCamera() async {
    if (widget.cameras.isEmpty) {
      return;
    }

    int cameraId = -1;
    try {
      final int cameraIndex = _cameraIndex % widget.cameras.length;
      final CameraDescription camera = widget.cameras[cameraIndex];

      cameraId = await CameraPlatform.instance.createCameraWithSettings(
        camera,
        _mediaSettings,
      );

      final Future<CameraInitializedEvent> initialized =
          CameraPlatform.instance.onCameraInitialized(cameraId).first;

      await CameraPlatform.instance.initializeCamera(
        cameraId,
      );

      final CameraInitializedEvent event = await initialized;
      _previewSize = Size(
        event.previewWidth,
        event.previewHeight,
      );

      if (mounted) {
        setState(() {
          _cameraId = cameraId;
          _cameraIndex = cameraIndex;
          _cameraInfo = 'Capturing camera: ${camera.name}';
        });
      }

      _startAutoCapture();
    } on CameraException catch (e) {
      try {
        if (cameraId >= 0) {
          await CameraPlatform.instance.dispose(cameraId);
        }
      } on CameraException catch (e) {
        debugPrint('Failed to dispose camera: ${e.code}: ${e.description}');
      }

      // Reset state.
      if (mounted) {
        setState(() {
          _cameraId = -1;
          _cameraIndex = 0;
          _previewSize = null;

          _cameraInfo =
              'Failed to initialize camera: ${e.code}: ${e.description}';
        });
      }
    }
  }

  void _startAutoCapture() async {
    while (true) {
      if (!isDetecting) {
        isDetecting = true;
        XFile? capturedImage;
        try {
          // 이미지 캡처
          capturedImage = await CameraPlatform.instance.takePicture(_cameraId);

          // 오디오 재생 (카메라 셔터 소리)
          await player.play(AssetSource('sounds/camera.mp3'));

          // 이미지를 Uint8List로 변환
          final bytes = await capturedImage.readAsBytes();
          setState(() {
            _imageData = bytes;
          });

          // 얼굴 인식 로직 (여기서는 예시로 항상 성공한다고 가정)
          bool isSubjectDetected = await detectSubject(bytes);

          setState(() {
            if (isSubjectDetected) {
              captureStatus = 1;
            } else {
              captureStatus = 2;
            }
          });

          await File(capturedImage.path).delete();
          if (isSubjectDetected) {
            setState(() {
              loginState = 1;
            });

            // // 3초 대기
            await Future.delayed(Duration(seconds: 3));
            // 캡처된 이미지 파일 삭제

            if (loginState == 1) {
              if (pageStatus == btnValue[0]) {
                uiCommon.SpMovePage(context, PAGE_REGIST_PAGE);
              } else {
                uiCommon.SpMovePage(context, PAGE_HOME_PAGE);
              }
            }

            break; // 성공하면 루프 종료
          } else {
            setState(() {
              loginState = 2; // 실패 상태
            });
          }
        } catch (e) {
          debugPrint('Error capturing image: $e');
        } finally {
          isDetecting = false;
        }
      }

      // 1초 대기 후 다음 캡처 시도
      await Future.delayed(Duration(seconds: 1));
    }
  }

  // 얼굴 인식 함(실제 구현은 별도로 해야 함)
  Future<bool> detectSubject(Uint8List imageBytes) async {
    try {
      // 이미지를 base64로 인코딩
      String base64Image = base64Encode(imageBytes);
      // API 엔드포인트 URL (실제 서버 주소로 변경해야 함)
      String apiUrl = 'http://192.168.0.128:5000/encoding';

      // POST 요청 보내기
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'image': base64Image,
        }),
      );

      if (response.statusCode == 200) {
        // 응답 처리
        Map<String, dynamic> result = jsonDecode(response.body);

        if (result["face_detected"]) {
          FaceRequestModel param = await FaceRequestModel(
            hostname: hostname,
            userType: userType,
            image: base64Image,
            sendDate: getCurrentDateTimeString(),
          );

          final loginApiCode = await Api.insertFace(param);
          if (pageStatus == btnValue[0]) {
            if (loginApiCode == '1000') {
              return true;
            } else {
              return false;
            }
          } else {
            if (loginApiCode == '1208') {
              return true;
            } else {
              return false;
            }
          }
        } else {
          return false; // 서버 응답에 따라 조정 필요
        }
      } else {
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error detecting subject: $e');
      return false;
    }
  }

  String getCurrentDateTimeString() {
    final now = DateTime.now();
    final formatter = DateFormat("yyyyMMdd_HHmmssSSS");
    return formatter.format(now);
  }

  String titleStr() {
    if (pageStatus == btnValue[0]) {
      return '얼굴 인식중...';
    } else {
      if (loginState == 0) {
        return '얼굴 인식중...';
      } else if (loginState == 1) {
        return '얼굴 인식 완료!';
      } else {
        return '얼굴 인식 실패!';
      }
    }
  }

  String subTitleStr() {
    if (pageStatus == btnValue[0]) {
      return '인식중일때는 잠시만 가만히 계세요.';
    } else {
      if (loginState == 0) {
        return '인식중일때는 잠시만 가만히 계세요.';
      } else if (loginState == 1) {
        return '메인화면으로 이동합니다.';
      } else {
        return '다시 진행하겠습니다.';
      }
    }
  }

  Color borederColor() {
    Color result = SpColors.lightGray3;
    if (captureStatus == 0) {
      result = SpColors.lightGray3;
    } else if (captureStatus == 1) {
      result = SpColors.blue;
    } else {
      result = SpColors.red;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Spbackground(
        childWidget: Container(
          padding: EdgeInsets.fromLTRB(0, 78, 0, 134),
          constraints: BoxConstraints(
            minWidth: 448,
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: uiCommon.styledText(
                    titleStr(),
                    24,
                    0,
                    1,
                    FontWeight.w700,
                    SpColors.titleText,
                    TextAlign.center,
                  ),
                ),
              ),
              SpSpace(spaceWidth: 0, spaceHeight: 11),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: uiCommon.styledText(
                    subTitleStr(),
                    18,
                    0,
                    1,
                    FontWeight.w400,
                    SpColors.titleText,
                    TextAlign.center,
                  ),
                ),
              ),
              SpSpace(spaceWidth: 0, spaceHeight: 43),
              Row(
                children: [
                  Spacer(),
                  Stack(
                    children: [
                      Container(
                        width: 305,
                        height: 386,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: borederColor()),
                        ),
                        child: ClipRect(
                          child: OverflowBox(
                            alignment: Alignment.center,
                            child: AspectRatio(
                              aspectRatio: _previewSize?.aspectRatio ?? 1,
                              child: CameraPlatform.instance
                                  .buildPreview(_cameraId),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: SizedBox(
                          child: Center(
                            child: SpImgBox1(
                              imageHeight: 331,
                              imagePath: "assets/img/img_frame.png",
                              imageFit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
