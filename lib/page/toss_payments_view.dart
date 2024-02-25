import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:user_core2/controller/loading_controller.dart';
import 'package:user_core2/controller/order_controller.dart';
import 'package:get/get.dart';
import 'package:user_core2/page/basic_toss_web_view.dart';
import 'package:user_core2/service/service.dart';
import 'package:user_core2/util/dialog.dart';

class TossPaymentsView extends StatelessWidget {
  const TossPaymentsView(
      {Key? key,
      required this.amount,
      required this.orderNo,
      required this.orderName,
      required this.paymentMethod,
      this.orderType = 'S',
      required this.successMethod,
      required this.flowMode,
      required this.controller})
      : super(key: key);
  final int amount;
  final String orderNo;
  final String orderName;
  final String paymentMethod;
  final String orderType;
  final Function successMethod;
  final String flowMode;
  final OrderController controller;

  @override
  Widget build(BuildContext context) {
    LoadingController loadingController = Get.put(LoadingController());

    var url =
        '${ServiceAPI.baseUrl}/payments/toss?method=$paymentMethod&orderId=$orderNo&amount=$amount&orderName=$orderName';
    if (controller.coupon.value != null) {
      url += '&couponId=${controller.coupon.value!.id}';
    }
    if (controller.point.value > 0) {
      url += '&pointAmount=${controller.point.value}';
    }
    if (paymentMethod == 'ePay' && controller.ePayCard.value != '') {
      url += '&flowMode=$flowMode&easyPay=${controller.ePayCard.value}';
    }
    var isCanceled = false;

    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        BasicTossWebView(
          viewUrl: url,
          onStartedFunction: (url) {
            log(url);
            loadingController.isLoading.value = false;
          },
          onFinishedFunction: (url) {
            if (url.contains('/success') && !isCanceled) {
              successMethod();
              isCanceled = true;
              return;
            }
            if (url.contains('/fail') && !isCanceled) {
              if (url.contains('/fail?code=PAY_PROCESS_CANCELED')) {
                Get.close(1);
                showBasicAlertDialog('결제를 취소하였습니다.');
                isCanceled = true;
                return;
              } else {
                Get.close(1);
                showBasicAlertDialog('결제를 실패하였습니다.');
                isCanceled = true;
                return;
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
