import 'package:flutter/material.dart';

class BasicStyle{
  ButtonStyle basicButtonStyle(EdgeInsets padding){
    return ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(padding),
      minimumSize: MaterialStateProperty.all(const Size(0, 0)),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    );
  }
}

