class SalesModel {
  String? salseNo;
  String? dateTime;
  String? storeName;
  String? salesCnt;
  String? totalSales;
  String? guestPrice;
  String? cash;
  String? card;
  String? point;
  String? credit;
  String? totalDiscount;
  String? etc1;
  String? etc2;
  String? serviceCharge;
  String? guestCnt;

  SalesModel({
    this.salseNo,
    this.dateTime,
    this.storeName,
    this.salesCnt,
    this.totalSales,
    this.guestPrice,
    this.cash,
    this.card,
    this.point,
    this.credit,
    this.totalDiscount,
    this.etc1,
    this.etc2,
    this.serviceCharge,
    this.guestCnt,
  });

  @override
  String toString() {
    return 'SalesModel(salseNo:$salseNo, dateTime:$dateTime, storeName:$storeName, salesCnt:$salesCnt, totalSales:$totalSales, guestPrice:$guestPrice, cash:$cash, card:$card, point:$point, credit:$credit, totalDiscount:$totalDiscount, etc1:$etc1, etc2:$etc2, serviceCharge:$serviceCharge, guestCnt:$guestCnt)';
  }

  factory SalesModel.fromJson(Map<String, dynamic> json) {
    return SalesModel(
      salseNo: json['salseNo'].toString(),
      dateTime: json['dateTime'].toString(),
      storeName: json['storeName'].toString(),
      salesCnt: json['salesCnt'].toString(),
      totalSales: json['totalSales'].toString(),
      guestPrice: json['guestPrice'].toString(),
      cash: json['cash'].toString(),
      card: json['card'].toString(),
      point: json['point'].toString(),
      credit: json['credit'].toString(),
      totalDiscount: json['totalDiscount'].toString(),
      etc1: json['etc1'].toString(),
      etc2: json['etc2'].toString(),
      serviceCharge: json['serviceCharge'].toString(),
      guestCnt: json['guestCnt'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'salseNo': salseNo,
        'dateTime': dateTime,
        'storeName': storeName,
        'salesCnt': salesCnt,
        'totalSales': totalSales,
        'guestPrice': guestPrice,
        'cash': cash,
        'card': card,
        'point': point,
        'credit': credit,
        'totalDiscount': totalDiscount,
        'etc1': etc1,
        'etc2': etc2,
        'serviceCharge': serviceCharge,
        'guestCnt': guestCnt,
      };
}
