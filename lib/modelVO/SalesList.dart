


import 'package:sosang/modelVO/salesModel.dart';

class Saleslist {
  final List<SalesModel>? list;

  Saleslist({
    this.list,
  });

  Saleslist.fromJson(Map<String, dynamic> json)
      : list = (json['List'] as List?)?.map((dynamic e) => SalesModel.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'List': list?.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'Saleslist(list:$list)';
  }
}
