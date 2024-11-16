import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sosang/Sp_widget/SpSpeechToText.dart';
import 'package:sosang/Sp_widget/SpSpeechToTextTb.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/common/utils.dart';
import 'package:sosang/constants/constants.dart';
import 'package:sosang/screen/Manual.dart';
import 'package:sosang/screen/Test.dart';
import 'package:sosang/screen/kiosk/Book_ki.dart';
import 'package:sosang/screen/kiosk/FloorPlan_ki.dart';
import 'package:sosang/screen/kiosk/Goods_ki.dart';
import 'package:sosang/screen/kiosk/Home_ki.dart';
import 'package:sosang/screen/kiosk/Intro_ki.dart';
import 'package:sosang/screen/kiosk/Login_ki.dart';
import 'package:sosang/screen/kiosk/Manual_ki.dart';
import 'package:sosang/screen/kiosk/Regist_ki.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:sosang/screen/tablet/Admin_tb.dart';
import 'package:sosang/screen/tablet/FloorPlan_tb.dart';
import 'package:sosang/screen/tablet/Intro_tb.dart';
import 'package:sosang/screen/tablet/Book_tb.dart';
import 'package:sosang/screen/tablet/Login_tb.dart';
import 'package:sosang/screen/tablet/Manual_tb.dart';
import 'package:window_manager/window_manager.dart';
import 'apiserver/faceService.dart';
import 'dart:io';

List<CameraDescription> _cameras = [];
String deviceType = ''; // 디바이스 정보 가져오기

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  deviceType = await getDeviceInfo(); // 디바이스 정보 가져오기

//Windows, Android Phone/Tablet, Android Emulator, iPhone/iPad, iOS Simulator, Unknown Device
  if (deviceType == "Windows") {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
        // size: Size(1990, 1180),
        // center: true,
        // backgroundColor: Colors.transparent,
        // skipTaskbar: false,
        // titleBarStyle: TitleBarStyle.normal,
        // fullScreen: true,
        // alwaysOnTop: true,
        // windowButtonVisibility: true,
        );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  } else if (deviceType == 'Android Phone/Tablet') {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  await dotenv.load(fileName: ".env");
  var mainpage = dotenv.env['MAIN'];
  var logLevel = dotenv.env['LOGLEVEL'];

  await GV.init(logLevel as String);

  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  const double iwidth = 1080;
  const double iheight = 1920;

  try {
    _cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }

  GV.init('DEBUG');
  GV.pStrg.putXXX(key_sst_value, 'sstValue');

  final service = FaceService();
  final server = await shelf_io.serve(service.handler, 'localhost', 5002);
  debugPrint('Server running on localhost:${server.port}');

  runApp(MyApp(mainPage: mainpage));
}

Future<String> getDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceType;

  // 현재 플랫폼 확인
  if (Platform.isWindows) {
    deviceType = 'Windows';
  } else if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceType = androidInfo.isPhysicalDevice ? 'Android Phone/Tablet' : 'Android Emulator';
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceType = iosInfo.isPhysicalDevice ? 'iPhone/iPad' : 'iOS Simulator';
  } else {
    deviceType = 'Unknown Device';
  }

  return deviceType;
}

class MyApp extends StatelessWidget {
  final String? mainPage;
  const MyApp({super.key, required this.mainPage});

  @override
  Widget build(BuildContext context) {
    GV.pStrg.getHistoryPages().isEmpty ? uiCommon.SpPushPage(context, mainPage!) : 1 == 1;
    PageTransitionsTheme _removeTransitions() {
      return PageTransitionsTheme(
        builders: {
          for (final platform in TargetPlatform.values) platform: const _NoTransitionsBuilder(),
        },
      );
    }

    return MaterialApp(
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
      ),
      title: 'Sosang',
      // theme:  ThemeData(pageTransitionsTheme: _removeTransitions()),
      initialRoute: "/${mainPage!}",
      debugShowCheckedModeBanner: false,
      routes: {
        //기존
        //TOOD 테블릿, 키오스크 전부 여기로 시작해야함
        "/$PAGE_INTRO_PAGE": (context) => (deviceType == 'Windows') ? IntroKi() : Intro_tb(),
        "/$PAGE_MANUAL_PAGE": (context) => const Manual(),
        "/$PAGE_TEST_PAGE": (context) => const Test(),
        "/$PAGE_SST_PAGE": (context) => const Spspeechtotext(),
        //키오스크
        "/$PAGE_LOGINKI_PAGE": (context) => LoginKi(cameras: _cameras),
        "/$PAGE_REGISTKI_PAGE": (context) => const RegistKi(),
        "/$PAGE_HOMEKI_PAGE": (context) => const HomeKi(),
        "/$PAGE_FLOORPLANKI_PAGE": (context) => const FloorPlanKi(),
        "/$PAGE_GOODSKI_PAGE": (context) => const GoodsKi(),
        "/$PAGE_BOOKKI_PAGE": (context) => const BookKi(),
        "/$PAGE_MANUALKI_PAGE": (context) => const ManualKi(),
        //태블릿
        "/$PAGE_INTRO_TB_PAGE": (context) => const Intro_tb(),
        "/$PAGE_FLOORPLAN_TB_PAGE": (context) => const FloorPlan_tb(),
        "/$PAGE_BOOK_TB_PAGE": (context) => const Book_tb(),
        "/$PAGE_MANUAL_TB_PAGE": (context) => const Manual_tb(),
        "/$PAGE_ADMIN_TB_PAGE": (context) => const Admin_tb(),
        "/$PAGE_LOGIN_TB_PAGE": (context) => const Login_tb(),
        "/$PAGE_SST_TB_PAGE": (context) => const SpSpeechToTextTb(),
      },
      home: Builder(
        builder: (BuildContext context) {
          ScreenUtil.init(context);
          return (deviceType == 'Windows') ? IntroKi() : Intro_tb();
        },
      ),
    );
  }
}

class _NoTransitionsBuilder extends PageTransitionsBuilder {
  const _NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    return child!;
  }
}
