import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tosspayments_widget_sdk_flutter/model/tosspayments_url.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_core2/controller/loading_controller.dart';
import 'package:user_core2/controller/order_controller.dart';
import 'package:get/get.dart';
import 'package:user_core2/service/service.dart';
import 'package:user_core2/util/dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

    Future<void> launchFunction(Uri url) async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    }

    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        WebView(
          initialUrl: Uri.parse(url).toString(),
          onPageStarted: (url) {
            loadingController.isLoading.value = false;
          },
          onPageFinished: (url) {
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
          navigationDelegate: (request) async {
            Uri uri = Uri.parse(request.url);
            // url 이 웹뷰에 유효하다면 해당 url 로 이동한다.
            if (uri.scheme == 'http' ||
                uri.scheme == 'https' ||
                uri.scheme == 'about') {
              return NavigationDecision.navigate;
            }

            if (Platform.isAndroid) {
              final appScheme =
                  ConvertUrl(request.url); // Intent URL을 앱 스킴 URL로 변환

              if (appScheme.isAppLink()) {
                // 앱 스킴 URL인지 확인
                appScheme.launchApp(
                    mode: LaunchMode
                        .externalApplication); // 앱 설치 상태에 따라 앱 실행 또는 마켓으로 이동
              }
            } else {
              launchFunction(uri);
            }

            return NavigationDecision.prevent;
          },
          javascriptMode: JavascriptMode.unrestricted,
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
