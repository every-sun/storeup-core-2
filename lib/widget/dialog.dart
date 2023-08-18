import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_core2/widget/text/notosans_text.dart';

class BasicAlertDialog extends StatelessWidget {
  const BasicAlertDialog({
    Key? key,
    required this.title,
    this.titleWeight = 'M',
    this.buttonTitle = '확인',
    this.method,
    this.buttonTitleColor = 0xff000000,
    this.buttonWeight = 'R',
    required this.radius,
    this.titleFontSize = 16,
    this.buttonFontSize = 16,
    required this.buttonPadding,
    required this.titlePadding,
  }) : super(key: key);
  final Function? method;
  final double radius;
  final String title;
  final String titleWeight;
  final EdgeInsets titlePadding;
  final double titleFontSize;
  final String buttonTitle;
  final int buttonTitleColor;
  final String buttonWeight;
  final EdgeInsets buttonPadding;
  final double buttonFontSize;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      buttonPadding: EdgeInsets.zero,
      titlePadding: titlePadding,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      title: NotoText(
        content: title,
        size: titleFontSize,
        weight: titleWeight,
        align: TextAlign.center,
        overflow: TextOverflow.visible,
      ),
      actions: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1,
                color: Color(0xffEDEDED),
              ),
            ),
          ),
          child: TextButton(
              onPressed: () {
                Get.back();
                if (method != null) method!();
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(buttonPadding),
                minimumSize: MaterialStateProperty.all(const Size(0, 0)),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: NotoText(
                content: buttonTitle,
                color: buttonTitleColor,
                size: buttonFontSize,
                weight: buttonWeight,
              )),
        )
      ],
    );
  }
}

class BasicConfirmDialog extends StatelessWidget {
  const BasicConfirmDialog(
      {Key? key,
      required this.title,
      required this.method,
      this.agreeTitle = '확인',
      this.cancelTitle = '취소',
      this.titleWeight = 'M',
      this.buttonWeight = 'R',
      this.cancelButtonColor = 0xff000000,
      this.agreeButtonColor = 0xff000000,
      required this.radius,
      this.titleFontSize = 16,
      this.buttonFontSize = 16,
      required this.buttonPadding,
      required this.titlePadding,
      required this.middleLineHeight})
      : super(key: key);
  final String title;
  final Function method;
  final String agreeTitle;
  final String cancelTitle;
  final int cancelButtonColor;
  final int agreeButtonColor;
  final double radius;
  final String titleWeight;
  final String buttonWeight;
  final EdgeInsets titlePadding;
  final EdgeInsets buttonPadding;
  final double titleFontSize;
  final double buttonFontSize;
  final double middleLineHeight;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      buttonPadding: EdgeInsets.zero,
      titlePadding: titlePadding,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      title: NotoText(
          content: title,
          size: titleFontSize,
          weight: titleWeight,
          align: TextAlign.center,
          overflow: TextOverflow.visible),
      actions: [
        Container(
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(
            width: 1,
            color: Color(0xffD3D3D3),
          ))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Expanded(
              child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all<EdgeInsets>(buttonPadding),
                    minimumSize: MaterialStateProperty.all(const Size(0, 0)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: NotoText(
                    content: cancelTitle,
                    color: cancelButtonColor,
                    weight: buttonWeight,
                  )),
            ),
            Container(
              width: 1,
              height: middleLineHeight,
              color: const Color(0xffD3D3D3),
            ),
            Expanded(
              child: TextButton(
                  onPressed: () {
                    Get.back();
                    method();
                  },
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all<EdgeInsets>(buttonPadding),
                    minimumSize: MaterialStateProperty.all(const Size(0, 0)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: NotoText(
                    content: agreeTitle,
                    color: agreeButtonColor,
                    weight: buttonWeight,
                  )),
            )
          ]),
        ),
      ],
    );
  }
}
