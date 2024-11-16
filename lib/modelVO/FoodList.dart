

import 'package:sosang/modelVO/FoodModel.dart';

class Foodlist {
  final List<Foodmodel>? list;

  Foodlist({
    this.list,
  });

  Foodlist.fromJson(Map<String, dynamic> json)
      : list = (json['List'] as List?)?.map((dynamic e) => Foodmodel.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'List': list?.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'Foodlist(list:$list)';
  }
}
