import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpChart.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpContentTitle.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpMenu.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/Sp_widget/SpTab.dart';
import 'package:sosang/api/api.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/constants/constants.dart';
import 'package:sosang/model/apiResult2.dart';
import 'package:sosang/model/variable.dart';
import 'package:sosang/modelVO/SalesList.dart';
import 'package:sosang/modelVO/SalesModel.dart';

class Admin_tb extends StatefulWidget {
  const Admin_tb({super.key});

  @override
  State<Admin_tb> createState() => _Admin_tbState();
}

class _Admin_tbState extends State<Admin_tb> {
  /* List<List<FlSpot>> chartDataList = []; */

  List<FlSpot> chartData = [];

  String standardYear = '';
  String standardMonth = '';
  String standardDay = '';

  List<Color> chartColorList = [
    SpColors.gradation2,
    SpColors.gradation6,
    SpColors.gradation11,
  ];

  int selectedIndex = 0;

  double maxDay = 0;

  List<String> btnTabList = ['시간', '일간', '주간', '월간'];
  List<bool> floorBtnClicks = [true, false, false, false];

  List<List<double>> chartMinMaxAverList = [
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0]
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final now = DateTime.now();
    final formatter = DateFormat("yyyy-MM");
    String today = formatter.format(now);
    standardYear = today.split('-')[0];
    standardMonth = today.split('-')[1];

    fetchData();
  }

  Future<void> fetchData() async {
    chartData = [];
    double totalPrice = 0;
    double turnNum = 0;
    String turnNumStr = '';
    int turnValue = 0;
    double max = double.negativeInfinity;
    double? min;

    final Saleslist? ret0 = await Api.getTimeSales();
    final Saleslist? ret1 = await Api.getDailySales();
    final Saleslist? ret2 = await Api.getWeeklySales();
    final Saleslist? ret3 = await Api.getMonthlySales();

    debugPrint('ret2 = $ret2');
    if (floorBtnClicks[2] == true) {
      chartData = [
        FlSpot(0, 0),
        FlSpot(1, 0),
        FlSpot(2, 0),
        FlSpot(3, 0),
        FlSpot(4, 0),
        FlSpot(5, 0),
        FlSpot(6, 0),
      ];
      if (ret2 != null) {
        turnValue = 0;
        turnNum = 0;

        for (var i = 0; i < ret2.list!.length; i++) {
          if (ret2.list![i].dateTime!.contains(standardMonth)) {
            /* turnNum = double.parse(ret2.list![i].salseNo.toString()) - 1; */
            totalPrice = double.parse(ret2!.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            /* chartData.add(FlSpot(turnNum, totalPrice)); */
            chartData[turnValue] = FlSpot(turnNum, totalPrice);
            turnValue++;
            turnNum++;

            if (totalPrice > max) {
              max = totalPrice;
            }
            if (min == null || totalPrice < min) {
              min = totalPrice;
            }
            if (min == null) {
              min = 0; // 또는 다른 적절한 기본값
            }
            chartMinMaxAverList[2] = [min!, max];
          }
        }
        // 유효한 데이터가 없을 경우 기본값 설정
      }
    } else if (floorBtnClicks[3] == true) {
      chartData = [
        FlSpot(0, 0),
        FlSpot(1, 0),
        FlSpot(2, 0),
        FlSpot(3, 0),
        FlSpot(4, 0),
        FlSpot(5, 0),
        FlSpot(6, 0),
        FlSpot(7, 0),
        FlSpot(8, 0),
        FlSpot(9, 0),
        FlSpot(10, 0),
        FlSpot(11, 0),
      ];
      if (ret3 != null) {
        turnNum = 0;
        turnValue = 0;
        for (var i = 0; i < ret3.list!.length; i++) {
          if (ret3.list![i].dateTime!.contains(standardYear)) {
            turnNumStr = ret3.list![i].dateTime!.split('-')[1].replaceAll('월', '');
            turnValue = int.parse(turnNumStr);
            totalPrice = double.parse(ret3!.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            chartData[turnValue - 1] = FlSpot(double.parse(turnNumStr) - 1, totalPrice);
            if (totalPrice > max) {
              max = totalPrice;
            }
            if (min == null || totalPrice < min) {
              min = totalPrice;
            }
            // 유효한 데이터가 없을 경우 기본값 설정
            if (min == null) {
              min = 0; // 또는 다른 적절한 기본값
            }
            chartMinMaxAverList[3] = [min!, max];
          }
        }
      }
    } else if (floorBtnClicks[1] == true) {
      chartData = [
        FlSpot(0, 0),
        FlSpot(1, 0),
        FlSpot(2, 0),
        FlSpot(3, 0),
        FlSpot(4, 0),
        FlSpot(5, 0),
        FlSpot(6, 0),
        FlSpot(7, 0),
        FlSpot(8, 0),
        FlSpot(9, 0),
        FlSpot(10, 0),
        FlSpot(11, 0),
        FlSpot(12, 0),
        FlSpot(13, 0),
        FlSpot(14, 0),
        FlSpot(15, 0),
        FlSpot(16, 0),
        FlSpot(17, 0),
        FlSpot(18, 0),
        FlSpot(19, 0),
        FlSpot(20, 0),
        FlSpot(21, 0),
        FlSpot(22, 0),
        FlSpot(23, 0),
        FlSpot(24, 0),
        FlSpot(25, 0),
        FlSpot(26, 0),
        FlSpot(27, 0),
        FlSpot(28, 0),
        FlSpot(29, 0),
        FlSpot(30, 0),
      ];
      if (ret1 != null) {
        for (var i = 0; i < ret1.list!.length; i++) {
          if (ret1.list![i].dateTime!.split('(')[0].substring(0, 7) == '$standardYear-$standardMonth') {
            turnValue = 0;
            turnNum = 0;
            /* turnNum = double.parse(ret2.list![i].salseNo.toString()) - 1; */
            if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '01') {
              turnNum = 0;
              turnValue = 0;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '02') {
              turnNum = 1;
              turnValue = 1;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '03') {
              turnNum = 2;
              turnValue = 2;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '04') {
              turnNum = 3;
              turnValue = 3;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '05') {
              turnNum = 4;
              turnValue = 4;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '06') {
              turnNum = 5;
              turnValue = 5;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '07') {
              turnNum = 6;
              turnValue = 6;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '08') {
              turnNum = 7;
              turnValue = 7;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '09') {
              turnNum = 8;
              turnValue = 8;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '10') {
              turnNum = 9;
              turnValue = 9;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '11') {
              turnNum = 10;
              turnValue = 10;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '12') {
              turnNum = 11;
              turnValue = 11;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '13') {
              turnNum = 12;
              turnValue = 12;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '14') {
              turnNum = 13;
              turnValue = 13;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '15') {
              turnNum = 14;
              turnValue = 14;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '16') {
              turnNum = 15;
              turnValue = 15;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '17') {
              turnNum = 16;
              turnValue = 16;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '18') {
              turnNum = 17;
              turnValue = 17;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '19') {
              turnNum = 18;
              turnValue = 18;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '20') {
              turnNum = 19;
              turnValue = 19;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '21') {
              turnNum = 20;
              turnValue = 20;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '22') {
              turnNum = 21;
              turnValue = 21;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '23') {
              turnNum = 22;
              turnValue = 22;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '24') {
              turnNum = 23;
              turnValue = 23;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '25') {
              turnNum = 24;
              turnValue = 24;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '26') {
              turnNum = 25;
              turnValue = 25;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '27') {
              turnNum = 26;
              turnValue = 26;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '28') {
              turnNum = 27;
              turnValue = 27;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '29') {
              turnNum = 28;
              turnValue = 28;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret1.list![i].dateTime!.split("(")[0].split("-")[2] == '30') {
              turnNum = 29;
              turnValue = 29;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else {
              turnNum = 30;
              turnValue = 30;
              totalPrice = double.parse(ret1.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            }
            chartData[turnValue] = FlSpot(turnNum, totalPrice);

            if (totalPrice > max) {
              max = totalPrice;
            }
            if (min == null || totalPrice < min) {
              min = totalPrice;
            }
            // 유효한 데이터가 없을 경우 기본값 설정
            if (min == null) {
              min = 0; // 또는 다른 적절한 기본값
            }
            chartMinMaxAverList[1] = [min!, max];
          }
        }
      }
    } else if (floorBtnClicks[0] == true) {
      chartData = [
        FlSpot(0, 0),
        FlSpot(1, 0),
        FlSpot(2, 0),
        FlSpot(3, 0),
        FlSpot(4, 0),
        FlSpot(5, 0),
        FlSpot(6, 0),
        FlSpot(7, 0),
        FlSpot(8, 0),
        FlSpot(9, 0),
        FlSpot(10, 0),
        FlSpot(11, 0),
        FlSpot(12, 0),
        FlSpot(13, 0),
        FlSpot(14, 0),
      ];
      if (ret0 != null) {
        turnValue = 0;
        turnNum = 0;
        for (var i = 0; i < ret0.list!.length; i++) {
          if (ret0.list![i].dateTime!.split(' ')[0].substring(0, 7) == '$standardYear-$standardMonth') {
            turnValue = 0;
            turnNum = 0;
            /* turnNum = double.parse(ret2.list![i].salseNo.toString()) - 1; */
            if (ret0.list![i].dateTime!.split(" ")[1] == '09') {
              turnNum = 0;
              turnValue = 0;
              totalPrice = double.parse(ret0.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret0.list![i].dateTime!.split(" ")[1] == '10') {
              turnNum = 1;
              turnValue = 1;
              totalPrice = double.parse(ret0.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret0.list![i].dateTime!.split(" ")[1] == '11') {
              turnNum = 2;
              turnValue = 2;
              totalPrice = double.parse(ret0.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret0.list![i].dateTime!.split(" ")[1] == '12') {
              turnNum = 3;
              turnValue = 3;
              totalPrice = double.parse(ret0.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret0.list![i].dateTime!.split(" ")[1] == '13') {
              turnNum = 4;
              turnValue = 4;
              totalPrice = double.parse(ret0.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret0.list![i].dateTime!.split(" ")[1] == '14') {
              turnNum = 5;
              turnValue = 5;
              totalPrice = double.parse(ret0.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret0.list![i].dateTime!.split(" ")[1] == '15') {
              turnNum = 6;
              turnValue = 6;
              totalPrice = double.parse(ret0.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret0.list![i].dateTime!.split(" ")[1] == '16') {
              turnNum = 7;
              turnValue = 7;
              totalPrice = double.parse(ret0.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret0.list![i].dateTime!.split(" ")[1] == '17') {
              turnNum = 8;
              turnValue = 8;
              totalPrice = double.parse(ret0.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret0.list![i].dateTime!.split(" ")[1] == '18') {
              turnNum = 9;
              turnValue = 9;
              totalPrice = double.parse(ret0.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret0.list![i].dateTime!.split(" ")[1] == '19') {
              turnNum = 10;
              turnValue = 10;
              totalPrice = double.parse(ret0.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret0.list![i].dateTime!.split(" ")[1] == '20') {
              turnNum = 11;
              turnValue = 11;
              totalPrice = double.parse(ret0.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret0.list![i].dateTime!.split(" ")[1] == '21') {
              turnNum = 12;
              turnValue = 12;
              totalPrice = double.parse(ret0.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else if (ret0.list![i].dateTime!.split(" ")[1] == '22') {
              turnNum = 13;
              turnValue = 13;
              totalPrice = double.parse(ret0.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            } else {
              turnNum = 14;
              turnValue = 14;
              totalPrice = double.parse(ret0.list![i].totalSales.toString().replaceAll(',', '')) / 1000000;
            }
            chartData[turnValue] = FlSpot(turnNum, totalPrice);

            if (totalPrice > max) {
              max = totalPrice;
            }
            if (min == null || totalPrice < min) {
              min = totalPrice;
            }
            // 유효한 데이터가 없을 경우 기본값 설정
            if (min == null) {
              min = 0; // 또는 다른 적절한 기본값
            }
            chartMinMaxAverList[0] = [min!, max];
          }
        }
      }
    }
    debugPrint('$chartMinMaxAverList');
    setState(() {});
  }

  void toggleFloorBtnColor(int index) {
    setState(() {
      // 모든 버튼을 비활성화
      for (int i = 0; i < floorBtnClicks.length; i++) {
        floorBtnClicks[i] = false;
      }
      // 클릭한 버튼만 활성화
      floorBtnClicks[index] = true;
    });
    fetchData();
  }

  void beforeMonth() {
    int year = 0;
    int month = 0;

    year = int.parse(standardYear);
    month = int.parse(standardMonth);

    if (standardMonth == '01') {
      year = year - 1;
      month = 12;
    } else {
      month = month - 1;
    }

    standardYear = '$year';

    if (month >= 10) {
      standardMonth = '$month';
    } else {
      standardMonth = '0$month';
    }

    setState(() {});
  }

  void afterMonth() {
    int year = 0;
    int month = 0;

    year = int.parse(standardYear);
    month = int.parse(standardMonth);

    if (standardMonth == '12') {
      year = year + 1;
      month = 1;
    } else {
      month = month + 1;
    }

    standardYear = '$year';

    if (month >= 10) {
      standardMonth = '$month';
    } else {
      standardMonth = '0$month';
    }

    setState(() {});
  }

  void afterYear() {
    int year = 0;
    year = int.parse(standardYear);
    year++;
    standardYear = '$year';
    setState(() {});
  }

  void beforeYear() {
    int year = 0;
    year = int.parse(standardYear);
    year--;
    standardYear = '$year';
    setState(() {});
  }

  double monthDayCnt() {
    int year = int.parse(standardYear);
    int month = int.parse(standardMonth);

    int daysInMonth = DateTime(year, month + 1, 0).day;
    maxDay = daysInMonth.toDouble() - 1;

    int leftNodayCnt = chartData.length - daysInMonth;

    if (leftNodayCnt > 0) {
      for (var i = 0; i < leftNodayCnt; i++) {
        chartData.removeAt(chartData.length - i - 1);
      }
    }

    return maxDay;
  }

  Widget bottomTitleWidgets1(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: SpColors.black,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text("09시", style: style);
        break;
      case 1:
        text = const Text('10시', style: style);
        break;
      case 2:
        text = const Text('11시', style: style);
        break;
      case 3:
        text = const Text('12시', style: style);
        break;
      case 4:
        text = const Text('13시', style: style);
        break;
      case 5:
        text = const Text('14시', style: style);
        break;
      case 6:
        text = const Text('15시', style: style);
        break;
      case 7:
        text = const Text('16시', style: style);
        break;
      case 8:
        text = const Text('17시', style: style);
        break;
      case 9:
        text = const Text('18시', style: style);
        break;
      case 10:
        text = const Text('19시', style: style);
        break;
      case 11:
        text = const Text('20시', style: style);
        break;
      case 12:
        text = const Text('21시', style: style);
        break;
      case 13:
        text = const Text('22시', style: style);
        break;
      case 14:
        text = const Text('23시', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return text;
  }

  Widget bottomTitleWidgets2(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: SpColors.black,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text("1일", style: style);
        break;
      case 1:
        text = const Text('2일', style: style);
        break;
      case 2:
        text = const Text('3일', style: style);
        break;
      case 3:
        text = const Text('4일', style: style);
        break;
      case 4:
        text = const Text('5일', style: style);
        break;
      case 5:
        text = const Text('6일', style: style);
        break;
      case 6:
        text = const Text('7일', style: style);
        break;
      case 7:
        text = const Text('8일', style: style);
        break;
      case 8:
        text = const Text('9일', style: style);
        break;
      case 9:
        text = const Text('10일', style: style);
        break;
      case 10:
        text = const Text('11일', style: style);
        break;
      case 11:
        text = const Text('12일', style: style);
        break;
      case 12:
        text = const Text('13일', style: style);
        break;
      case 13:
        text = const Text('14일', style: style);
        break;
      case 14:
        text = const Text('15일', style: style);
        break;
      case 15:
        text = const Text('16일', style: style);
        break;
      case 16:
        text = const Text('17일', style: style);
        break;
      case 17:
        text = const Text('18일', style: style);
        break;
      case 18:
        text = const Text('19일', style: style);
        break;
      case 19:
        text = const Text('20일', style: style);
        break;
      case 20:
        text = const Text('21일', style: style);
        break;
      case 21:
        text = const Text('22일', style: style);
        break;
      case 22:
        text = const Text('23일', style: style);
        break;
      case 23:
        text = const Text('24일', style: style);
        break;
      case 24:
        text = const Text('25일', style: style);
        break;
      case 25:
        text = const Text('26일', style: style);
        break;
      case 26:
        text = const Text('27일', style: style);
        break;
      case 27:
        text = const Text('28일', style: style);
        break;
      case 28:
        text = const Text('29일', style: style);
        break;
      case 29:
        text = const Text('30일', style: style);
        break;
      case 30:
        text = const Text('31일', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return text;
  }

  Widget bottomTitleWidgets3(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: SpColors.black,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text("월", style: style);
        break;
      case 1:
        text = const Text('화', style: style);
        break;
      case 2:
        text = const Text('수', style: style);
        break;
      case 3:
        text = const Text('목', style: style);
        break;
      case 4:
        text = const Text('금', style: style);
        break;
      case 5:
        text = const Text('토', style: style);
        break;
      case 6:
        text = const Text('일', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return text;
  }

  Widget bottomTitleWidgets4(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: SpColors.black,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text("01월", style: style);
        break;
      case 1:
        text = const Text('02월', style: style);
        break;
      case 2:
        text = const Text('03월', style: style);
        break;
      case 3:
        text = const Text('04월', style: style);
        break;
      case 4:
        text = const Text('05월', style: style);
        break;
      case 5:
        text = const Text('06월', style: style);
        break;
      case 6:
        text = const Text('07월', style: style);
        break;
      case 7:
        text = const Text('08월', style: style);
        break;
      case 8:
        text = const Text('09월', style: style);
        break;
      case 9:
        text = const Text('10월', style: style);
        break;
      case 10:
        text = const Text('11월', style: style);
        break;
      case 11:
        text = const Text('12월', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return text;
  }

  Widget leftTitleWidgets1(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: SpColors.black,
    );

    return Text('', style: style, textAlign: TextAlign.left);
  }

  Widget leftTitleWidgets2(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: SpColors.black,
    );

    return Text('', style: style, textAlign: TextAlign.left);
  }

  Widget leftTitleWidgets3(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: SpColors.black,
    );

    return Text('', style: style, textAlign: TextAlign.left);
  }

  Widget leftTitleWidgets4(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: SpColors.black,
    );

    return Text('', style: style, textAlign: TextAlign.left);
  }

  Widget chartWidget1(
    Function() onBtnPressed,
    List<FlSpot> chartData,
    Color chartColor1,
    /* WaterFilter filter */
  ) {
    return Column(
      children: [
        SpSpace(spaceWidth: 0, spaceHeight: 4),
        Container(
          child: Spchart(
            chartData: chartData,
            gridDataVisible: true,
            flGridData: FlGridData(
              show: true,
              drawHorizontalLine: false,
              drawVerticalLine: false,
              verticalInterval: 1,
              horizontalInterval: 20,
            ),
            leftSideTitlesVisible: true,
            topSideTitlesVisible: false,
            rightSideTitlesVisible: false,
            bottomSideTitlesVisible: true,
            reservedSize: const [6, 0, 0, 60],
            interval: const [1, 0, 0, 1],
            leftCharSide: leftTitleWidgets1,
            topCharSide: leftTitleWidgets1,
            rightCharSide: leftTitleWidgets1,
            bottomCharSide: bottomTitleWidgets1,
            chartBorderVisible: true,
            chartBorder: Border(
              bottom: BorderSide(width: 1, color: SpColors.textBoxHint),
              left: BorderSide(width: 1, color: SpColors.textBoxHint),
            ),
            minX: 0,
            maxX: 14,
            minY: 0,
            maxY: 8.5,
            chartColor1: chartColor1,
            chartColor2: SpColors.invisiable,
            isCurved: false,
            chartLineWidth: 2,
            isStrokeCapRound: false,
            dotData: true,
            belowBarData: false,
            beginGradient: Alignment.topCenter,
            endGradient: Alignment.bottomCenter,
            chartWidth: 1200,
            chartHeight: 430,
          ),
        ),
      ],
    );
  }

  Widget chartWidget2(
    Function() onBtnPressed,
    List<FlSpot> chartData,
    Color chartColor1,
    /* WaterFilter filter */
  ) {
    return Column(
      children: [
        SpSpace(spaceWidth: 0, spaceHeight: 4),
        Container(
          child: Spchart(
            chartData: chartData,
            gridDataVisible: true,
            flGridData: FlGridData(
              show: true,
              drawHorizontalLine: false,
              drawVerticalLine: false,
              verticalInterval: 1,
              horizontalInterval: 10,
            ),
            leftSideTitlesVisible: true,
            topSideTitlesVisible: false,
            rightSideTitlesVisible: false,
            bottomSideTitlesVisible: true,
            reservedSize: const [6, 0, 0, 60],
            interval: const [1, 0, 0, 1],
            leftCharSide: leftTitleWidgets2,
            topCharSide: leftTitleWidgets2,
            rightCharSide: leftTitleWidgets2,
            bottomCharSide: bottomTitleWidgets2,
            chartBorderVisible: true,
            chartBorder: Border(
              bottom: BorderSide(width: 1, color: SpColors.textBoxHint),
              left: BorderSide(width: 1, color: SpColors.textBoxHint),
            ),
            minX: 0,
            maxX: monthDayCnt(),
            minY: 0,
            maxY: 4.5,
            chartColor1: chartColor1,
            chartColor2: SpColors.invisiable,
            isCurved: false,
            chartLineWidth: 2,
            isStrokeCapRound: false,
            dotData: true,
            belowBarData: false,
            beginGradient: Alignment.topCenter,
            endGradient: Alignment.bottomCenter,
            chartWidth: 1200,
            chartHeight: 430,
          ),
        ),
      ],
    );
  }

  Widget chartWidget3(
    Function() onBtnPressed,
    List<FlSpot> chartData,
    Color chartColor1,
    /* WaterFilter filter */
  ) {
    return Column(
      children: [
        SpSpace(spaceWidth: 0, spaceHeight: 4),
        Container(
          child: Spchart(
            chartData: chartData,
            gridDataVisible: true,
            flGridData: FlGridData(
              show: true,
              drawHorizontalLine: false,
              drawVerticalLine: false,
              verticalInterval: 1,
              horizontalInterval: 50,
            ),
            leftSideTitlesVisible: true,
            topSideTitlesVisible: false,
            rightSideTitlesVisible: false,
            bottomSideTitlesVisible: true,
            reservedSize: const [6, 0, 0, 60],
            interval: const [1, 0, 0, 1],
            leftCharSide: leftTitleWidgets3,
            topCharSide: leftTitleWidgets3,
            rightCharSide: leftTitleWidgets3,
            bottomCharSide: bottomTitleWidgets3,
            chartBorderVisible: true,
            chartBorder: Border(
              bottom: BorderSide(width: 1, color: SpColors.textBoxHint),
              left: BorderSide(width: 1, color: SpColors.textBoxHint),
            ),
            minX: 0,
            maxX: 6,
            minY: chartMinMaxAverList[2][0],
            maxY: chartMinMaxAverList[2][1],
            chartColor1: chartColor1,
            chartColor2: SpColors.invisiable,
            isCurved: false,
            chartLineWidth: 2,
            isStrokeCapRound: false,
            dotData: true,
            belowBarData: false,
            beginGradient: Alignment.topCenter,
            endGradient: Alignment.bottomCenter,
            chartWidth: 1200,
            chartHeight: 430,
          ),
        ),
      ],
    );
  }

  Widget chartWidget4(
    Function() onBtnPressed,
    List<FlSpot> chartData,
    Color chartColor1,
    /* WaterFilter filter */
  ) {
    return Column(
      children: [
        SpSpace(spaceWidth: 0, spaceHeight: 4),
        Container(
          child: Spchart(
            chartData: chartData,
            gridDataVisible: true,
            flGridData: FlGridData(
              show: true,
              drawHorizontalLine: false,
              drawVerticalLine: false,
              verticalInterval: 1,
              horizontalInterval: 200,
            ),
            leftSideTitlesVisible: true,
            topSideTitlesVisible: false,
            rightSideTitlesVisible: false,
            bottomSideTitlesVisible: true,
            reservedSize: const [6, 0, 0, 60],
            interval: const [1, 0, 0, 1],
            leftCharSide: leftTitleWidgets4,
            topCharSide: leftTitleWidgets4,
            rightCharSide: leftTitleWidgets4,
            bottomCharSide: bottomTitleWidgets4,
            chartBorderVisible: true,
            chartBorder: Border(
              bottom: BorderSide(width: 1, color: SpColors.textBoxHint),
              left: BorderSide(width: 1, color: SpColors.textBoxHint),
            ),
            minX: 0,
            maxX: 11,
            minY: 0,
            maxY: 85,
            chartColor1: chartColor1,
            chartColor2: SpColors.invisiable,
            isCurved: false,
            chartLineWidth: 2,
            isStrokeCapRound: false,
            dotData: true,
            belowBarData: false,
            beginGradient: Alignment.topCenter,
            endGradient: Alignment.bottomCenter,
            chartWidth: 1200,
            chartHeight: 430,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Spbackground(
            childWidget: Container(
              color: SpColors.white,
              padding: EdgeInsets.all(40),
              constraints: BoxConstraints(
                minWidth: 448,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpcontentTitle(
                    pageTitle: (floorBtnClicks[3] == true) ? '$standardYear년' : '$standardYear년 $standardMonth월',
                    pageTitleSize: 32,
                    padding: 16,
                    subMenu: Row(
                      children: List.generate(
                        btnTabList.length,
                        (index) => Row(
                          children: [
                            SpBtn(
                                onBtnPressed: () => toggleFloorBtnColor(index),
                                childWidget: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    border:
                                        Border.all(width: 1, color: floorBtnClicks[index] ? SpColors.invisiable : SpColors.textBoxBorder),
                                    color: floorBtnClicks[index] ? SpColors.black : SpColors.white,
                                  ),
                                  child: uiCommon.styledText(btnTabList[index], 14, 0, 1.6, FontWeight.w600,
                                      floorBtnClicks[index] ? SpColors.white : SpColors.black, TextAlign.center),
                                )),
                            SpSpace(spaceWidth: 12, spaceHeight: 0)
                          ],
                        ),
                      ),
                    ),
                    leftBtn: Row(
                      children: [
                        SpBtn(
                            onBtnPressed: () {
                              if (floorBtnClicks[3] == true) {
                                beforeYear();
                              } else {
                                beforeMonth();
                              }
                              fetchData();
                            },
                            childWidget:
                                SpImgBox1(imagePath: 'assets/img/icon_date_btn_left.png', imageFit: BoxFit.fitWidth, imageWidth: 32)),
                        SpSpace(spaceWidth: 16, spaceHeight: 0)
                      ],
                    ),
                    rigthBtn: Row(
                      children: [
                        SpSpace(spaceWidth: 16, spaceHeight: 0),
                        SpBtn(
                            onBtnPressed: () {
                              if (floorBtnClicks[3] == true) {
                                afterYear();
                              } else {
                                afterMonth();
                              }
                              fetchData();
                            },
                            childWidget:
                                SpImgBox1(imagePath: 'assets/img/icon_date_btn_right.png', imageFit: BoxFit.fitWidth, imageWidth: 32)),
                      ],
                    ),
                  ),
                  Row(children: [
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SpSpace(spaceWidth: 0, spaceHeight: 30),
                        uiCommon.styledText('총 매출', 24, 0, 1.5, FontWeight.w700, SpColors.titleText, TextAlign.left),
                        SpSpace(spaceWidth: 0, spaceHeight: 30),
                        uiCommon.styledText('단위 : 백만원', 14, 0, 1.5, FontWeight.w700, SpColors.black, TextAlign.center),
                        SpSpace(spaceWidth: 0, spaceHeight: 10),
                        Visibility(
                          visible: floorBtnClicks[0] == true,
                          child: chartWidget1(() {}, chartData, SpColors.green),
                        ),
                        Visibility(
                          visible: floorBtnClicks[1] == true,
                          child: chartWidget2(() {}, chartData, SpColors.green),
                        ),
                        Visibility(
                          visible: floorBtnClicks[2] == true,
                          child: chartWidget3(() {}, chartData, SpColors.green),
                        ),
                        Visibility(
                          visible: floorBtnClicks[3] == true,
                          child: chartWidget4(() {}, chartData, SpColors.green),
                        ),
                        SpSpace(spaceWidth: 0, spaceHeight: 20),
                        Container(
                          width: 1200,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SpBtn(
                              onBtnPressed: () {
                                uiCommon.SpMovePage(context, PAGE_INTRO_TB_PAGE);
                              },
                              childWidget: Container(
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: SpColors.orange,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: uiCommon.styledText("메인으로", 18, 0, 1, FontWeight.w700, SpColors.white, TextAlign.center),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                  ])
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
