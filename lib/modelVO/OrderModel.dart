class OrderModel {
  String? product;
  int? num;
  

  OrderModel({
    this.product,
    this.num,
   
  });

  @override
  String toString() {
    return 'OrderModel(code:$product, foodImg:$num)';
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      product: json['product'] as String?,
      num: json['num'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'product': product,
        'num': num,
      };
}
