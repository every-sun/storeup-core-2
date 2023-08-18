import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BasicIconButton extends StatelessWidget {
  const BasicIconButton({Key? key, required this.padding, this.iconColor,
    required this.iconName, this.iconSize, required this.method}) : super(key: key);
  final EdgeInsets padding;
  final String iconName;
  final double? iconSize;
  final Function method;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        method();
      },
      constraints: const BoxConstraints(),
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      padding: padding,
      iconSize: iconSize,
      icon: SvgPicture.asset('assets/icons/$iconName.svg', color: iconColor),
    );
  }
}
