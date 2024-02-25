import 'package:flutter/material.dart';
import 'package:user_core2/page/basic_toss_web_view.dart';

class ReceiptView extends StatelessWidget {
  const ReceiptView({Key? key, required this.url, required this.appbar})
      : super(key: key);
  final String url;
  final PreferredSizeWidget appbar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar, body: SafeArea(child: BasicTossWebView(viewUrl: url)));
  }
}
