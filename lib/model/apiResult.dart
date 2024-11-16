// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class ApiResult {
  ApiResult({
    // required this.code,
    // this.message,
    // required this.data,
    // this.serviceCode,

    //얼굴인식 API
    this.hostname,
    this.retCode,
    this.retMsg,
    this.sendDate,
    this.detail,
    this.answer,
  });
  // String? code;
  // dynamic message;
  // dynamic data;
  // String? serviceCode;

//얼굴인식 API
  String? hostname;
  int? retCode;
  String? retMsg;
  String? sendDate;
  String? detail;
  String? answer;

  ApiResult.fromJson(Map<String, dynamic> json) {
    // code = json['code'];
    // message = json['message'];
    // data = json['data'];
    // serviceCode = json['serviceCode'];

    //얼굴인식 API
    hostname = json['hostname'];
    retCode = json['retCode'];
    retMsg = json['retMsg'];
    sendDate = json['sendDate'];
    detail = json['detail'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // _data['code'] = code;
    // _data['message'] = message;
    // _data['data'] = data;
    // _data['serviceCode'] = serviceCode;

    //얼굴인식 API
    _data['hostname'] = hostname;
    _data['retCode'] = retCode;
    _data['retMsg'] = retMsg;
    _data['sendDate'] = sendDate;
    _data['detail'] = detail;
    _data['answer'] = answer;
    return _data;
  }

  @override
  String toString() {
    // return 'ApiResult(code: $code, message: $message, data: $data, serviceCode: $serviceCode, hostname: $hostname, retCode: $retCode, retMsg: $retMsg, sendDate: $sendDate)';
    return 'ApiResult(hostname: $hostname, retCode: $retCode, retMsg: $retMsg, sendDate: $sendDate, detail: $detail, answer: $answer)';
  }
}
