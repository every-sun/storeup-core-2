import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpostal/kpostal.dart';
import 'package:user_core2/widget/button/icon_button.dart';
import 'package:user_core2/widget/text/notosans_text.dart';

class ZipcodeSearchViewPage extends StatelessWidget {
  const ZipcodeSearchViewPage(
      {Key? key, required this.inputMethod, required this.setPostCodeMethod})
      : super(key: key);
  final Function inputMethod;
  final Function setPostCodeMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color.fromRGBO(0, 0, 0, 0.5),
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: KpostalView(
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              actions: <Widget>[
                BasicIconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  iconName: 'close',
                  method: () {
                    Get.back();
                  },
                  iconColor: const Color(0xffc7c7c7),
                  iconSize: 32,
                )
              ],
              title: const NotoText(
                content: '우편번호 검색',
                color: 0xff484848,
                size: 18,
                weight: 'M',
              ),
            ),
            callback: (Kpostal result) {
              setPostCodeMethod(result.postCode);
              inputMethod(result.address);
            },
          ),
        ),
      ),
    );
  }
}
