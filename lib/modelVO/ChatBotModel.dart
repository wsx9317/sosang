import 'package:sosang/modelVO/OrderModel.dart';

class ChatBotModel {
  String? intent;
  String? message;
  String? response;
  String? chair_num;
  String? detail;
  String? answer;
  List<OrderModel>? order_list;

  ChatBotModel({this.intent, this.message, this.response, this.detail, this.chair_num, this.answer, this.order_list});

  ChatBotModel.fromJson(Map<String, dynamic> json) {
    intent = json['intent'];
    message = json['message'];
    response = json['response'];
    chair_num = json['chair_num'];
    detail = json['detail'];
    answer = json['answer'];
    order_list = (json['order_list'] as List?)?.map((dynamic e) => OrderModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intent'] = this.intent;
    data['message'] = this.message;
    data['response'] = this.response;
    data['chair_num'] = this.chair_num;
    data['detail'] = this.detail;
    data['answer'] = this.answer;
    data['order_list'] = this.order_list;
    return data;
  }
}
