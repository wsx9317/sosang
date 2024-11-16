class Foodmodel {
  String? code;
  String? foodImg;
  String? foodName;
  String? recomend;
  String? time;

  Foodmodel({
    this.code,
    this.foodImg,
    this.foodName,
    this.recomend,
    this.time,
  });

  @override
  String toString() {
    return 'Foodmodel(code:$code, foodImg:$foodImg, foodName:$foodName, recomend:$recomend, time:$time)';
  }

  factory Foodmodel.fromJson(Map<String, dynamic> json) {
    return Foodmodel(
      code: json['code'] as String?,
      foodImg: json['foodImg'] as String?,
      foodName: json['foodName'] as String?,
      recomend: json['recomend'] as String?,
      time: json['time'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'foodImg': foodImg,
        'foodName': foodName,
        'recomend': recomend,
        'time': time,
      };
}
