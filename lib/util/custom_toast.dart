import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_core2/widget/text/notosans_text.dart';

void showCustomToast(context, text, width, position, milliseconds) {
  final fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: const Color.fromRGBO(67, 67, 67, 0.95),
    ),
    child: NotoText(
      content: text,
      color: 0xffffffff,
      size: 14,
      overflow: TextOverflow.visible,
    ),
  );

  fToast.showToast(
      child: toast,
      toastDuration: Duration(milliseconds: milliseconds),
      positionedToastBuilder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            position == 'T'
                ? Positioned(
                    top: 52,
                    child: child,
                  )
                : Positioned(
                    bottom: 52,
                    child: child,
                  )
          ],
        );
      });
}
