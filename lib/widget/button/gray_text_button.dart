import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:user_core2/widget/basic_style.dart';
import 'package:user_core2/widget/text/notosans_text.dart';

class GrayTextButton extends StatelessWidget {
  const GrayTextButton({Key? key, required this.method, this.fontSize=14,
    required this.title, required this.padding, this.color=Colors.black, this.isLine=false}) : super(key: key);
  final Function method;
  final double fontSize;
  final String title;
  final EdgeInsets padding;
  final Color color;
  final bool isLine;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (){
          method();
        },
        style: BasicStyle().basicButtonStyle(padding),
        child: isLine?Get.deviceLocale?.languageCode=='ko'?Text(title, style: TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: 'NotoSansKR',
            fontSize: fontSize,
            decoration: TextDecoration.underline,
            color: color
        ),):Text(title, style: TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: 'NotoSansKR',
            fontSize: fontSize,
            decoration: TextDecoration.underline,
            color: color
        ),).translate():NotoText(content: title, size: fontSize, rgba: color,)
    );
  }
}
