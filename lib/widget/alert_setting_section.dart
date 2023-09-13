import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/auth.dart';
import 'package:user_core2/service/user_service.dart';
import 'package:user_core2/util/dialog.dart';
import 'package:user_core2/widget/text/notosans_text.dart';
import 'package:user_core2/widget/text/roboto_text.dart';

class AlertSettingSection extends StatefulWidget {
  const AlertSettingSection(
      {Key? key, required this.appName, required this.appColor})
      : super(key: key);
  final String appName;
  final int appColor;

  @override
  State<AlertSettingSection> createState() => _AlertSettingSectionState();
}

class _AlertSettingSectionState extends State<AlertSettingSection> {
  bool _isSmsOn = false;
  bool _isEmailOn = false;
  bool _isPushOn = false;
  bool _isServiceNotificationOn = false;
  bool _isNighttimeServiceNotificationOn = false;
  UserController controller = Get.put(UserController());

  @override
  void initState() {
    setPushInfo();
    super.initState();
  }

  Future<void> setPushInfo() async {
    if (controller.customer.value == null) return;
    try {
      Map<dynamic, dynamic> data =
          await UserServices.getAgreementInfo(controller.customer.value!.id);
      setState(() {
        _isSmsOn = data['marketing_notification']['sms']['is_agree'];
        _isEmailOn = data['marketing_notification']['email']['is_agree'];
        _isPushOn = data['marketing_notification']['push']['is_agree'];
        _isServiceNotificationOn = data['service_notification']['is_agree'];
        _isNighttimeServiceNotificationOn =
            data['nighttime_service_notification']['is_agree'];
      });
    } catch (err) {
      showBasicAlertDialog('알림수신동의 여부 정보를 가져오지 못했습니다.');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy년MM월dd일 hh시 mm분');
    void showDialogMessage(title, agree) {
      showBasicAlertDialog("${widget.appName} $title 수신 여부가 '$agree'로 변경되었습니다."
          '\n${formatter.format(DateTime.now())}');
    }

    final Customer? customer = Get.find<UserController>().customer.value;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: widget.appName == '나드리' ? 0 : 7,
                    color: const Color.fromRGBO(242, 242, 242, 1)),
                bottom: const BorderSide(width: 1, color: Color(0xffe8e8e8)))),
        padding: const EdgeInsets.all(20),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotoText(
              content: '이벤트 및 혜택 알림',
              size: 14,
              weight: 'B',
            ),
            SizedBox(
              height: 5,
            ),
            Opacity(
              opacity: 0.5,
              child: NotoText(content: '알림을 켜고 다양한 이벤트 정보를 받아보세요.', size: 12),
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(20, 25.1, 20, 20),
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 7, color: Color(0xfff2f2f2)))),
        child: Wrap(
          runSpacing: 20,
          children: [
            _toggleItem('SMS 수신 동의', 'R', () {
              if (controller.isLoading.value) return;
              controller.updateAgreementInfo({'sms': !_isSmsOn}, () {
                setState(() {
                  _isSmsOn = !_isSmsOn;
                });
                if (_isSmsOn) {
                  showDialogMessage('이벤트 문자 알림', '수신 동의');
                } else {
                  showDialogMessage('이벤트 문자 알림', '수신 거부');
                }
              });
            }, _isSmsOn),
            _toggleItem('이메일', 'R', () {
              if (controller.isLoading.value) return;
              controller.updateAgreementInfo({'email': !_isEmailOn}, () {
                setState(() {
                  _isEmailOn = !_isEmailOn;
                });
                if (_isEmailOn) {
                  showDialogMessage('이벤트 이메일 알림', '수신 동의');
                } else {
                  showDialogMessage('이벤트 이메일 알림', '수신 거부');
                }
              });
            }, _isEmailOn),
            _toggleItem('앱 푸시', 'R', () {
              if (controller.isLoading.value) return;
              controller.updateAgreementInfo({'push': !_isPushOn}, () {
                setState(() {
                  _isPushOn = !_isPushOn;
                });
                if (_isPushOn) {
                  showDialogMessage('이벤트 푸시 알림', '수신 동의');
                } else {
                  showDialogMessage('이벤트 푸시 알림', '수신 거부');
                }
              });
            }, _isPushOn),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 7, color: Color(0xfff2f2f2)))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _toggleItem('서비스 알림', 'B', () {
                  if (controller.isLoading.value) return;
                  controller.updateAgreementInfo(
                      {'service': !_isServiceNotificationOn}, () {
                    setState(() {
                      _isServiceNotificationOn = !_isServiceNotificationOn;
                    });
                    if (_isServiceNotificationOn) {
                      showDialogMessage('서비스 알림', '수신 동의');
                    } else {
                      showDialogMessage('서비스 알림', '수신 거부');
                    }
                  });
                }, _isServiceNotificationOn),
                NotoText(
                    content: '${widget.appName} 서비스 관련 정보를 알려드릴게요.',
                    size: 12,
                    rgba: const Color.fromRGBO(0, 0, 0, 0.5))
              ],
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 7, color: Color(0xfff2f2f2)))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _toggleItem('야간 알림 수신', 'B', () {
              if (controller.isLoading.value) return;
              controller.updateAgreementInfo(
                  {'nighttime': !_isNighttimeServiceNotificationOn}, () {
                setState(() {
                  _isNighttimeServiceNotificationOn =
                      !_isNighttimeServiceNotificationOn;
                });
                if (_isNighttimeServiceNotificationOn) {
                  showDialogMessage('야간 서비스 알림', '수신 동의');
                } else {
                  showDialogMessage('야간 서비스 알림', '수신 거부');
                }
              });
            }, _isNighttimeServiceNotificationOn),
            const Opacity(
              opacity: 0.5,
              child: RobotoText(
                content: '21 : 00 ~ 08 : 00',
                size: 12,
              ),
            ),
            NotoText(
                content: '알림으로 ${widget.appName} 혜택을 받아보세요.',
                size: 12,
                rgba: const Color.fromRGBO(0, 0, 0, 0.5))
          ],
        ),
      )
    ]);
  }

  Widget _toggleItem(title, fontWeight, Function toggleMethod, bool isTrue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NotoText(content: title, size: 14, weight: fontWeight),
        GestureDetector(
          onTap: () {
            toggleMethod();
          },
          child: Container(
            width: 52,
            height: 30,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color:
                    isTrue ? Color(widget.appColor) : const Color(0xffcccccc),
                borderRadius: BorderRadius.circular(50)),
            child: AnimatedAlign(
                alignment:
                    isTrue ? Alignment.centerRight : Alignment.centerLeft,
                duration: const Duration(milliseconds: 150),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                )),
          ),
        )
      ],
    );
  }
}
