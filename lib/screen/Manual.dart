import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpBackground.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpContent.dart';
import 'package:sosang/Sp_widget/SpMenu.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/model/variable.dart';

class Manual extends StatefulWidget {
  const Manual({super.key});

  @override
  State<Manual> createState() => _ManualState();
}

class _ManualState extends State<Manual> {
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
                pageTitle: '사용방법',
                subMenu: SizedBox(),
                childWidget:
                    //TODO 변경 될 곳
                    Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: SpColors.lightGray3,
                ),
                recordBtn: () {},
              ),
              Spmenu(
                pageNum: 4,
                device: Device.kiosk,
              )
            ],
          ),
        ),
      ),
    );
  }
}
