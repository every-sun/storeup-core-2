import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_core2/widget/text/notosans_text.dart';

class BasicFillButton extends StatelessWidget {
  const BasicFillButton(
      {Key? key,
        required this.title,
        required this.method,
      required this.padding,
      this.width = double.infinity,
        required this.height,
      this.isActive = true,
        required this.borderRadius,
        required this.fontSize,
        required this.fontWeight,
        required this.fontColor,
      this.isLoading, required this.buttonActiveColor, required this.buttonColor})
      : super(key: key);
  final String title;
  final Function method;
  final EdgeInsets padding;
  final double width;
  final double? height;
  final bool isActive;
  final double borderRadius;
  final double fontSize;
  final String fontWeight;
  final int fontColor;
  final RxBool? isLoading;
  final Color buttonActiveColor;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    RxBool loading = isLoading == null ? false.obs : isLoading!;
    return SizedBox(
        width: width,
        height: height,
        child: TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius))),
              backgroundColor: isActive
                  ? buttonActiveColor
                  : buttonColor,
              padding: padding,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: Colors.transparent),
          onPressed: () {
            if (loading.value) return;
            method();
          },
          child: Obx(() => loading.value
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 2,
                  ),
                )
              : NotoText(
                  content: title,
                  color: fontColor,
                  size: fontSize,
                  weight: fontWeight,
                )),
        ));
  }
}
