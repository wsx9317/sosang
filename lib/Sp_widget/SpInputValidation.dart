import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:sosang/Sp_widget/SpColor.dart';
import 'package:sosang/Sp_widget/SpImgBox1.dart';
import 'package:sosang/Sp_widget/SpSpace.dart';
import 'package:sosang/common/globalvar.dart';
import 'package:sosang/common/uiCommon.dart';

class SpInputValidation extends StatefulWidget {
  final String? lable;
  final double width;
  final double height;
  final double verticalPadding;
  final double horizontalPadding;
  final int? maxLength;
  final Color inputColor;
  final Color? borderColor;
  final double round;
  final Function()? onTap;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function()? onEdit;
  final bool? nextFocus;
  final Function(String)? onChange;
  final String textAlign;
  final Color? enabledBorderColor;
  final String hintText;
  final double hintTextFontSize;
  final FontWeight hintTextfontWeight;
  final Color hintTextFontColor;
  final String keyboardType;
  final Widget? inputWithIcon;
  final bool showSearchIcon;
  final double? iconSize;
  final double? iconVerticalSize;
  final double? iconleftSize;
  final String validationText;
  final bool validationVisible;
  final bool vlaidationCheck;
  final bool enabledBool;
  SpInputValidation({
    super.key,
    this.lable,
    required this.width,
    required this.height,
    required this.verticalPadding,
    required this.horizontalPadding,
    this.maxLength,
    required this.inputColor,
    this.borderColor,
    required this.round,
    this.onTap,
    this.controller,
    this.focusNode,
    this.onEdit,
    this.nextFocus,
    this.onChange,
    required this.textAlign,
    this.enabledBorderColor,
    required this.hintText,
    required this.hintTextFontSize,
    required this.hintTextfontWeight,
    required this.hintTextFontColor,
    required this.keyboardType,
    this.inputWithIcon,
    required this.showSearchIcon,
    this.iconSize,
    this.iconVerticalSize,
    this.iconleftSize,
    required this.validationText,
    required this.validationVisible,
    required this.vlaidationCheck,
    required this.enabledBool,
  });

  @override
  State<SpInputValidation> createState() => _SpInputValidationState();
}

class _SpInputValidationState extends State<SpInputValidation> {
  @override
  void initState() {
    super.initState();
    if (widget.keyboardType == 'number') {
      widget.controller!.addListener(_formatNumber);
    }
  }

  void _formatNumber() {
    if (widget.controller!.text.isNotEmpty) {
      String value = widget.controller!.text.replaceAll(',', '');
      value = value.replaceAll(' ', '');
      int number = 0;
      try {
        number = int.tryParse(value) ?? 0;
      } catch (e) {}
      String formattedValue = numberWithCommas(number);
      if (widget.controller!.text != formattedValue) {
        widget.controller!.value = widget.controller!.value.copyWith(
          text: formattedValue,
          selection: TextSelection.collapsed(offset: formattedValue.length),
        );
      }
    }
  }

  String numberWithCommas(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
        );
  }

  @override
  Widget build(BuildContext context) {
    Widget wg1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (widget.lable != null)
            ? Column(
                children: [
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.5),
                      child: uiCommon.styledText(
                          (widget.lable != null) ? widget.lable! : '', 18, 0, 1.6, FontWeight.w600, SpColors.titleText, TextAlign.left),
                    ),
                  ),
                  SpSpace(spaceWidth: 0, spaceHeight: 8),
                ],
              )
            : SizedBox(),
        Stack(
          children: [
            Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.inputColor,
                borderRadius: BorderRadius.circular(widget.round),
                // 여기가 보더색상
                border: Border.all(color: (widget.borderColor != null) ? widget.borderColor! : widget.inputColor, width: 1),
              ),
              child: TextFormField(
                maxLength: widget.maxLength ?? 100,
                inputFormatters: [],
                onTap: widget.onTap,
                focusNode: (widget.focusNode != null) ? widget.focusNode : null,
                controller: (widget.controller != null) ? widget.controller : null,
                onEditingComplete: widget.onEdit,
                onFieldSubmitted: (value) {
                  (widget.nextFocus == true) ? FocusScope.of(context).nextFocus() : null;
                },
                onChanged: (widget.keyboardType == 'number3')
                    ? (value) {
                        if (value.length == 6) {
                          widget.controller!.text = '${value.substring(0, 6)}-';
                        } else if (value.length == 6 || value.length == 7) {
                          widget.controller!.text = widget.controller!.text.replaceAll('-', '');
                        }
                      }
                    : widget.onChange,
                enabled: widget.enabledBool,
                obscureText: (widget.keyboardType == 'password' || widget.keyboardType == 'password2') ? true : false,
                textAlign: (widget.textAlign == 'start')
                    ? TextAlign.start
                    : (widget.textAlign == 'end')
                        ? TextAlign.end
                        : TextAlign.center,
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding, vertical: widget.verticalPadding),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.round), borderSide: BorderSide.none),
                  //에러 날때
                  enabledBorder: (widget.enabledBorderColor != null)
                      ? OutlineInputBorder(
                          borderSide:
                              BorderSide(color: (widget.validationVisible) ? SpColors.red : const Color.fromRGBO(0, 0, 0, 0), width: 1.0),
                          borderRadius: BorderRadius.circular(widget.round),
                        )
                      : null,
                  //엑티브 됐을때
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: SpColors.titleText, width: 1.0),
                    borderRadius: BorderRadius.circular(widget.round),
                  ),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    height: 2,
                    fontSize: widget.hintTextFontSize,
                    color: widget.hintTextFontColor,
                    fontWeight: widget.hintTextfontWeight,
                  ),
                ),
                keyboardType: (widget.keyboardType == 'number' ||
                        widget.keyboardType == 'number2' ||
                        widget.keyboardType == 'number3' ||
                        widget.keyboardType == 'password2')
                    ? TextInputType.number
                    : TextInputType.text,
                style: TextStyle(
                    color: SpColors.black,
                    fontFamily: 'Pretendard',
                    fontSize: widget.hintTextFontSize,
                    height: 1,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Visibility(
              visible: widget.showSearchIcon,
              child: Positioned(
                top: widget.iconVerticalSize ?? 0,
                left: widget.iconleftSize ?? 0,
                bottom: widget.iconVerticalSize ?? 0,
                child: SizedBox(
                  width: widget.iconSize ?? 0,
                  height: widget.iconSize ?? 0,
                  child: Center(
                    child: widget.inputWithIcon,
                  ),
                ),
              ),
            )
          ],
        ),
        Visibility(
          visible: widget.validationVisible,
          child: Column(
            children: [
              const SpSpace(spaceWidth: 0, spaceHeight: 4),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: SpImgBox1(imagePath: 'assets/img/icon_tool_04.png', imageWidth: 16, imageHeight: 16, imageFit: BoxFit.cover),
                  ),
                  const SpSpace(spaceWidth: 4, spaceHeight: 0),
                  uiCommon.styledText(widget.validationText, 14, 0, 1.6, FontWeight.w400, SpColors.red, TextAlign.left),
                ],
              ),
            ],
          ),
        ),
      ],
    );
    return wg1;
  }
}
