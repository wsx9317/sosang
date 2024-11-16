import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sosang/api/api.dart';
import 'package:sosang/modelVO/ChatBotModel.dart';

Future<void> sstFetchData(String message, String page) async {
  debugPrint('hello world');
  debugPrint('check : $page');

  ChatBotModel param = ChatBotModel(message: message);

  debugPrint('check : $param');

  if (page == 'menu') {
    debugPrint('hello world1');
    final ChatBotModel? ret2 = await Api.menuChatBot(param);
    if (ret2 != null) {
      debugPrint('chatBot Check2 : ${ret2.intent}');
      debugPrint('chatBot Check2 : ${ret2.response}');
      for (var i = 0; i < ret2.order_list!.length; i++) {
        debugPrint('chatBot Check2 : ${ret2.order_list![i].product}');
        debugPrint('chatBot Check2 : ${ret2.order_list![i].num}');
      }
    }
  } else if (page == 'book') {
    debugPrint('hello world2');
    final ChatBotModel? ret3 = await Api.bookChatBot(param);
    if (ret3 != null) {
      debugPrint('chatBot Check3 : ${ret3.response!}');
    }
  } else {
    final ChatBotModel? ret1 = await Api.mainChatBot(param);
    if (ret1 != null) {
      debugPrint('chatBot Check1 : ${ret1.intent!}');
      debugPrint('chatBot Check1 : ${ret1.response!}');
    }
  }
}
