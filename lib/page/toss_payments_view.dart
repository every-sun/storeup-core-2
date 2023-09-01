import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toss_payment/feature/payments/webview/payment_webview.dart';
import 'package:user_core2/controller/loading_controller.dart';
import 'package:user_core2/util/dialog.dart';
import 'package:user_core2/service/service.dart';

class TossPaymentsView extends StatelessWidget {
  const TossPaymentsView(
      {Key? key,
      required this.amount,
      required this.orderNo,
      required this.orderName,
      required this.paymentMethod,
      this.orderType = 'S',
      required this.successMethod,
      required this.flowMode})
      : super(key: key);
  final int amount;
  final String orderNo;
  final String orderName;
  final String paymentMethod;
  final String orderType;
  final Function successMethod;
  final String flowMode; // TODO

  @override
  Widget build(BuildContext context) {
    LoadingController loadingController = Get.put(LoadingController());
    var url = // TODO url
        '${ServiceAPI().baseUrl}/payments/toss?method=$paymentMethod&orderId=$orderNo&amount=$amount&orderName=$orderName';
    // if (paymentMethod == 'ePay' && controller.ePayCard.value != '') {
    //   url += '&flowMode=$flowMode&easyPay=${controller.ePayCard.value}';
    // }
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        PaymentWebView(
          onTapCloseButton: () {
            Navigator.of(context).pop();
          },
          paymentRequestUrl: Uri.parse(url),
          onPageStarted: (url) {
            loadingController.isLoading.value = false;
          },
          onDisposed: () {
            loadingController.isLoading.value = false;
          },
          onPageFinished: (url) {
            if (url.contains('/success')) {
              if (orderType == 'S' || orderType == 'N') {
                successMethod();
              }
            }
            if (url.contains('/fail')) {
              if (url.contains('/fail?code=PAY_PROCESS_CANCELED')) {
                Get.close(1);
              } else {
                Get.close(1);
                showBasicAlertDialog('결제를 실패하였습니다.');
              }
            }
          },
        ),
        Obx(() => Visibility(
              visible: loadingController.isLoading.value,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ))
      ],
    )));
  }
}
