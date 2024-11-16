
import 'package:sosang/modelVO/BookModel.dart';

class Booklist {
  final List<Bookmodel>? list;

  Booklist({
    this.list,
  });

  Booklist.fromJson(Map<String, dynamic> json)
      : list = (json['List'] as List?)?.map((dynamic e) => Bookmodel.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'List': list?.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'Booklist(list:$list)';
  }
}
