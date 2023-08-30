import 'package:flutter/material.dart';
import 'package:toss_payment/feature/payments/webview/payment_webview.dart';

class ReceiptView extends StatelessWidget {
  const ReceiptView({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: PaymentWebView(
          onTapCloseButton: (){
            Navigator.of(context).pop();
          },
          paymentRequestUrl: Uri.parse(url),
        ))
    );
  }
}
