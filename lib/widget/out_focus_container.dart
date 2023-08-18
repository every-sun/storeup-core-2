import 'package:flutter/material.dart';

class OutFocusContainer extends StatelessWidget {
  const OutFocusContainer({Key? key, required this.child, this.isResize=true, this.appBar, this.bottomNaviButton}) : super(key: key);
  final Widget child;
  final bool isResize;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNaviButton;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: appBar,
        resizeToAvoidBottomInset: isResize,
        body: SafeArea(
          child: child,
        ),
        bottomNavigationBar: bottomNaviButton,
      ),
    );
  }
}
