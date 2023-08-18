import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';

class RobotoText extends StatelessWidget {
  const RobotoText({Key? key, required this.content, this.size=16, this.color=0xff000000, this.height,
    this.overflow=TextOverflow.ellipsis, this.weight='R', this.rgba, this.spacing}) : super(key: key);
  final String content;
  final int color;
  final Color? rgba;
  final double size;
  final TextOverflow overflow;
  final String weight;
  final double? spacing;
  final double? height;

  @override
  Widget build(BuildContext context) {
    Text textWidget = Text(content, style: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: weight=='R'?FontWeight.w400:(weight=='B'?FontWeight.w700:FontWeight.w500),
      fontSize: size,
      overflow: overflow,
      letterSpacing: spacing,
      height: height,
      color: rgba??Color(color),
    ),
    );
    return Get.deviceLocale?.languageCode=='ko'?textWidget:textWidget.translate();
  }
}
