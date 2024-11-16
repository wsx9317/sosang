// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class ApiResult2 {
  ApiResult2({
    required this.IsSuccess,
    required this.Data,
    this.ErrorMsg,
  });
  bool? IsSuccess;
  dynamic Data;
  dynamic ErrorMsg;

  ApiResult2.fromJson(Map<String, dynamic> json) {
    IsSuccess = json['IsSuccess'];
    Data = json['Data'];
    ErrorMsg = json['ErrorMsg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['IsSuccess'] = IsSuccess;
    _data['Data'] = Data;
    _data['ErrorMsg'] = ErrorMsg;
    return _data;
  }

  @override
  String toString() {
    return 'ApiResult(isSuccess: $IsSuccess, data: $Data, errorMsg: $ErrorMsg)';
  }
}

class UiotApiResult {
  bool? success;
  String? detail;
  String? content;
  String? token;
  int? unixTime;

  UiotApiResult({this.success, this.detail, this.content, this.token});

  UiotApiResult.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? true;
    detail = json['detail'] ?? "";
    content = json['content'] ?? "";
    token = json['token'] ?? "";
    unixTime = json['unixTime'] ?? (DateTime.now().millisecondsSinceEpoch ~/ 1000);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = this.success;
    data['detail'] = this.detail;
    data['content'] = this.content;
    data['token'] = this.token;
    data['unixTime'] = this.unixTime;
    return data;
  }

  String get decodedContent {
    return fromBase64(content!);
  }

  static String fromBase64(String src) {
    var ret = utf8.decode(base64.decode(src));
    if (ret == 'null') ret = '';
    return ret;
  }

  static String toBase64(String src) {
    return base64.encode(utf8.encode(src));
  }

  @override
  String toString() {
    return 'success:$success , content ' + decodedContent;
  }
}
