import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';

class NotoText extends StatelessWidget {
  const NotoText({Key? key, required this.content, this.size=16, this.color=0xff000000, this.height, this.spacing,
    this.overflow=TextOverflow.ellipsis, this.rgba, this.weight='R', this.maxLines, this.underLine=false, this.align}) : super(key: key);
  final String content;
  final int color;
  final double size;
  final TextOverflow overflow;
  final Color? rgba;
  final double? height;
  final double? spacing;
  final String weight;
  final bool underLine;
  final TextAlign? align;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    Text textWidget = Text(
      content,
      textAlign: align,
      style: TextStyle(
        fontFamily: 'NotoSansKR',
        fontWeight: weight=='R'?FontWeight.w400:(weight=='B'?FontWeight.w700:FontWeight.w500),
        fontSize: size,
        height: height,
        letterSpacing: spacing,
        overflow: overflow,
        decoration: underLine?TextDecoration.underline:null,
        color: rgba??Color(color),
      ),
      maxLines: maxLines,
    );
    return Get.deviceLocale?.languageCode=='ko'?textWidget:textWidget.translate();
  }
}