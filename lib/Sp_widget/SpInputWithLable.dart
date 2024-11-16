import 'package:flutter/material.dart';
import 'dart:typed_data';
// import 'package:flutter_osk_x/flutter_osk.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpInputValidation.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/common/uiCommon.dart';
import 'package:sosang/model/windowsOsk.dart';

class SpInputWithLable extends StatefulWidget {
  final String lable;
  final String hint;
  final TextEditingController controller;
  final String keyboarType;
  final int maxLength;
  final bool editAble;
  final Function() onTap;
  const SpInputWithLable({
    super.key,
    required this.lable,
    required this.hint,
    required this.controller,
    required this.keyboarType,
    required this.maxLength,
    required this.editAble,
    required this.onTap,
  });

  @override
  State<SpInputWithLable> createState() => _SpInputWithLableState();
}

class _SpInputWithLableState extends State<SpInputWithLable> {
  Widget textInputWidget(String hint, TextEditingController controller, String keyboarType, int maxLength) {
    return SpInputValidation(
      width: double.infinity,
      height: 72,
      verticalPadding: 11,
      horizontalPadding: 35,
      inputColor: SpColors.white,
      borderColor: SpColors.textBoxBorder,
      round: 12,
      maxLength: maxLength,
      textAlign: 'start',
      controller: controller,
      hintText: hint,
      showSearchIcon: false,
      hintTextFontSize: 28,
      hintTextfontWeight: FontWeight.w400,
      hintTextFontColor: SpColors.textBoxHint,
      keyboardType: keyboarType,
      validationText: '',
      validationVisible: false,
      vlaidationCheck: false,
      enabledBool: widget.editAble,
      onTap: widget.onTap,
      onEdit: () {
        WindowsOSK.close();
      },
      // onTap: () {
      //   WindowsOSK.show();
      // },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        uiCommon.styledText(widget.lable, 28, 0, 2, FontWeight.w700, SpColors.black100Per, TextAlign.left),
        SpSpace(spaceWidth: 0, spaceHeight: 8),
        textInputWidget(widget.hint, widget.controller, widget.keyboarType, widget.maxLength),
        SpSpace(spaceWidth: 0, spaceHeight: 24)
      ],
    );
  }
}
