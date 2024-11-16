// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sosang/common/sql.dart';
import 'package:sosang/constants/constants.dart';
import 'package:sosang/model/apiResult.dart';
import 'package:sosang/model/apiResult2.dart';
import 'package:sosang/modelVO/BookList.dart';
import 'package:sosang/modelVO/ChatBotModel.dart';
import 'package:sosang/modelVO/FaceRequestModel.dart';
import 'package:sosang/modelVO/FoodList.dart';
import 'package:sosang/modelVO/MyInforItem.dart';
import 'package:sosang/modelVO/SalesList.dart';

import '../common/globalvar.dart';
import '../common/utils.dart';

class SpApiPreParam {
  Map<String, String> headers = {'Content-Type': 'application/json'};
  http.Client? client;
  Uri? uri;

  @override
  String toString() => 'SpApiPreParam(headers: $headers, client: $client, uri: $uri)';
}

class Api {
  static MyInfoItem? LoggedUser() {
    MyInfoItem? login1;
    try {
      var loginStr1 = GV.pStrg.getXXX(key_gv_login);
      login1 = MyInfoItem.fromJson(jsonDecode(loginStr1));
    } catch (e) {
      debugPrint("$e");
    }
    return login1;
  }

  static String _authHeader() {
    String result = '';
    // MyInfoItem? login1 = GV.myInfoItem;
    // if (login1 != null) result = login1.accessToken ?? '';
    return result;
  }

  static SpApiPreParam? authTokenHttp({String? url}) {
    SpApiPreParam result = SpApiPreParam();
    result.client = http.Client();
    if (url != null) {
      result.uri = Uri.parse(url);
    } else {
      return null;
    }

    var bear1 = _authHeader();
    result.headers = {'accept': '*/*', 'Content-Type': 'application/json'};
    if (bear1.isNotEmpty) result.headers['Authorization'] = 'Bearer $bear1';
    return result;
  }

  //로그인
  static Future<String?> authFace(FaceRequestModel param) async {
    var c1 = Api.authTokenHttp(url: SP_BASE_URI + Face_Auth);
    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: jsonEncode(param.toJson())).timeout(Duration(seconds: 5));
      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        debugPrint("상태1 : $_api1");
        return _api1.retCode.toString();
      } else {
        debugPrint('Failed to load insertFace');
      }
    } catch (e) {
      debugPrint('$e');
    }
    return null;
  }

  //얼굴 등록
  static Future<String?> insertFace(FaceRequestModel param) async {
    var c1 = Api.authTokenHttp(url: SP_BASE_URI + Face_Add);
    try {
      final response = await c1?.client!.post(c1.uri!, headers: c1.headers, body: jsonEncode(param.toJson())).timeout(Duration(seconds: 5));
      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ApiResult.fromJson(item1);
        debugPrint("상태2 : $_api1");
        return _api1.retCode.toString();
      } else {
        debugPrint('Failed to load insertFace');
      }
    } catch (e) {
      debugPrint('$e');
    }
    return null;
  }

  //챗봇_메인
  static Future<dynamic> mainChatBot(ChatBotModel param) async {
    var c1 = Api.authTokenHttp(url: SP_BASE_URI2 + Chat_Bot_Main);

    debugPrint('param = ${param}');
    debugPrint('SP_BASE_URI2 = ${SP_BASE_URI2}');
    debugPrint('Chat_Bot_Main = ${Chat_Bot_Main}');
    try {
      final response =
          await c1?.client!.post(c1.uri!, headers: c1.headers, body: jsonEncode(param.toJson())).timeout(Duration(seconds: 10));
      debugPrint('check999 = ${response!.statusCode}');
      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ChatBotModel.fromJson(item1);
        return _api1;
      }
    } catch (e) {
      debugPrint('$e');
    }
    return null;
  }

  //챗봇_메뉴
  static Future<dynamic> menuChatBot(ChatBotModel param) async {
    var c1 = Api.authTokenHttp(url: SP_BASE_URI2 + Chat_Bot_Menu);

    try {
      final response =
          await c1?.client!.post(c1.uri!, headers: c1.headers, body: jsonEncode(param.toJson())).timeout(Duration(seconds: 10));

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        var _api1 = ChatBotModel.fromJson(item1);
        return _api1;
      }
    } catch (e) {
      debugPrint('$e');
    }
    return null;
  }

  //챗봇_도서
  static Future<dynamic> bookChatBot(ChatBotModel param) async {
    var c1 = Api.authTokenHttp(url: SP_BASE_URI2 + Chat_Bot_Book);
    try {
      final response =
          await c1?.client!.post(c1.uri!, headers: c1.headers, body: jsonEncode(param.toJson())).timeout(Duration(seconds: 10));
      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> item1 = jsonDecode(utf8.decode(response.bodyBytes));
        debugPrint('check123 : $item1');
        var _api1 = ChatBotModel.fromJson(item1);
        return _api1;
      }
    } catch (e) {
      debugPrint('$e');
    }
    return null;
  }

  //음식
  static Future<dynamic> getFood() async {
    try {
      var _api1 = ApiResult2.fromJson(getFoodData);
      Foodlist? data1 = Foodlist.fromJson(_api1.Data);
      return data1;
    } catch (e) {
      print(e);
    }
    return null;
  }

  //도서
  static Future<dynamic> getBook() async {
    try {
      var _api1 = ApiResult2.fromJson(getBookData);
      Booklist? data1 = Booklist.fromJson(_api1.Data);
      return data1;
    } catch (e) {
      print(e);
    }
    return null;
  }

  //시간매출
  static Future<dynamic> getTimeSales() async {
    try {
      var _api1 = ApiResult2.fromJson(timeSalesData);
      Saleslist? data1 = Saleslist.fromJson(_api1.Data);
      return data1;
    } catch (e) {
      print(e);
    }
    return null;
  }

  //일일매출
  static Future<dynamic> getDailySales() async {
    try {
      var _api1 = ApiResult2.fromJson(dailySalesData);
      Saleslist? data1 = Saleslist.fromJson(_api1.Data);
      return data1;
    } catch (e) {
      print(e);
    }
    return null;
  }

  //주매출
  static Future<dynamic> getWeeklySales() async {
    try {
      var _api1 = ApiResult2.fromJson(weeklySalesData);
      Saleslist? data1 = Saleslist.fromJson(_api1.Data);
      return data1;
    } catch (e) {
      print(e);
    }
    return null;
  }

  //월매출
  static Future<dynamic> getMonthlySales() async {
    try {
      var _api1 = ApiResult2.fromJson(monthlySalesData);
      Saleslist? data1 = Saleslist.fromJson(_api1.Data);
      return data1;
    } catch (e) {
      print(e);
    }
    return null;
  }

  //내정보 update
//   static Future<dynamic> updateMember(MyInfoUpdateItem param, Uint8List imgData, String imgName) async {
//     var dio = Dio();
//     dio.options.headers = {
//       Headers.contentTypeHeader: 'multipart/form-data',
//     };
//     var bear1 = _authHeader();
//     if (bear1.isNotEmpty) dio.options.headers['Authorization'] = 'Bearer $bear1';

//     var formData = FormData.fromMap({
//       'file': MultipartFile.fromBytes(imgData, filename: imgName, contentType: MediaType.parse('multipart/form-data')),
//       'userInfo': MultipartFile.fromString(jsonEncode(param), contentType: MediaType.parse('application/json'))
//     });

//     try {
//       final response = await dio.post(ID_BASE_URI + ID_MyInfo_Update, data: formData);
//       if (response != null && response.statusCode == 200) {
//         if (response.data['message'] == 'SUCCESS') {
//           GV.pStrg.putLastUsed();
//           return 'SUCCESS';
//         } else {
//           GV.d('Failed to load updateMember');
//         }
//       }
//     } catch (e) {
//       print(e);
//     }

//     return null;
//   }
}
