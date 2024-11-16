class Bookmodel {
  int? bookId;
  String? area1;
  String? area2;
  String? writer;
  String? title;
  String? type;
  String? etc1;
  String? etc2;
  String? registDateTime;

  Bookmodel(
      {this.bookId,
      this.area1,
      this.area2,
      this.writer,
      this.title,
      this.type,
      this.etc1,
      this.etc2,
      this.registDateTime});

  @override
  String toString() {
    return 'Bookmodel(bookId:$bookId, area1:$area1, area2:$area2, writer:$writer, title:$title, type:$type, etc1:$etc1, etc2:$etc2, registDateTime:$registDateTime)';
  }

  factory Bookmodel.fromJson(Map<String, dynamic> json) {
    return Bookmodel(
      bookId: json['bookId'] as int?,
      area1: json['area1'].toString(),
      area2: json['area2'].toString(),
      writer: json['writer'].toString(),
      title: json['title'].toString(),
      type: json['type'].toString(),
      etc1: json['etc1'].toString(),
      etc2: json['etc2'].toString(),
      registDateTime: json['registDateTime'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'bookId': bookId,
        'area1': area1,
        'area2': area2,
        'writer': writer,
        'title': title,
        'type': type,
        'etc1': etc1,
        'etc2': etc2,
        'registDateTime': registDateTime,
      };
}
