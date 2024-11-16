import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpBtn.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpContent.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpMenu.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/model/variable.dart';

class FloorPlan extends StatefulWidget {
  const FloorPlan({super.key});

  @override
  State<FloorPlan> createState() => _FloorPlanState();
}

class _FloorPlanState extends State<FloorPlan> {
  List<String> subMenuNmList = [];
  int submenuNum = 0;
  List<String> floorPalnList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

//임시
  Future<void> fetchData() async {
    subMenuNmList = ['1F', '2F'];
    floorPalnList = [
      'assets/img/img_floor_sample.png',
      'assets/img/img_floor_sample2.png'
    ];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget floorPlanImg() {
    return SpImgBox1(
        imageWidth: double.infinity,
        imagePath: floorPalnList[submenuNum],
        imageFit: BoxFit.fitWidth);
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
                pageTitle: '전체도면',
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
                childWidget: floorPlanImg(),
                recordBtn: () {
                  print('녹음');
                },
              ),
              Spmenu(
                pageNum: 1,
                device: Device.kiosk,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
