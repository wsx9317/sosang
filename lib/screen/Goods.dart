import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpContent.dart';
import 'package:sosang/Sp_widget/SpMenu.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/model/variable.dart';

class Goods extends StatefulWidget {
  const Goods({super.key});

  @override
  State<Goods> createState() => _GoodsState();
}

class _GoodsState extends State<Goods> {
  List<String> subMenuNmList = [];
  int submenuNum = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

//임시
  Future<void> fetchData() async {
    subMenuNmList = ['커피', '디카페인', '디저트'];
  }

//TODO 추후에 변경될곳
  Widget goodsWidth() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: (submenuNum == 0)
            ? SpColors.gradation1
            : (submenuNum == 1)
                ? SpColors.gradation4
                : SpColors.gradation7,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Spbackground(
        childWidget: Container(
          padding: EdgeInsets.fromLTRB(32, 32, 32, 40),
          constraints: BoxConstraints(
            minWidth: 448,
          ),
          child: Column(
            children: [
              Spcontent(
                  pageTitle: '메뉴',
                  subMenu: Row(
                    children: List.generate(
                      subMenuNmList.length,
                      (index) => Row(
                        children: [
                          SpSpace(spaceWidth: 16, spaceHeight: 0),
                          SpBtn(
                            onBtnPressed: () {
                              setState(() {
                                submenuNum = index;
                              });
                            },
                            childWidget: Container(
                              height: 24,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: (submenuNum == index) ? 2 : 0,
                                    color: (submenuNum == index)
                                        ? SpColors.black
                                        : SpColors.invisiable,
                                  ),
                                ),
                              ),
                              child: uiCommon.styledText(
                                  subMenuNmList[index],
                                  15,
                                  0,
                                  1,
                                  FontWeight.w700,
                                  SpColors.titleText,
                                  TextAlign.right),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  childWidget: goodsWidth(),
                  recordBtn: () {}),
              Spmenu(
                pageNum: 2,
                device: Device.kiosk,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
