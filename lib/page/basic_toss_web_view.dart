import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tosspayments_widget_sdk_flutter/model/tosspayments_url.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BasicTossWebView extends StatelessWidget {
  const BasicTossWebView(
      {Key? key,
      required this.viewUrl,
      this.onFinishedFunction,
      this.onStartedFunction})
      : super(key: key);
  final String viewUrl;
  final Function(String)? onStartedFunction;
  final Function(String)? onFinishedFunction;

  @override
  Widget build(BuildContext context) {
    Future<void> launchFunction(Uri url) async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    }

    return WebView(
      initialUrl: Uri.parse(viewUrl).toString(),
      onPageStarted: onStartedFunction,
      onPageFinished: onFinishedFunction,
      navigationDelegate: (request) async {
        Uri uri = Uri.parse(request.url);
        // url 이 웹뷰에 유효하다면 해당 url 로 이동한다.
        if (uri.scheme == 'http' ||
            uri.scheme == 'https' ||
            uri.scheme == 'about') {
          return NavigationDecision.navigate;
        }

        if (Platform.isAndroid) {
          log(request.url);
          final appScheme = ConvertUrl(request.url); // Intent URL을 앱 스킴 URL로 변환

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
    );
  }
}
