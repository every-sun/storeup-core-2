import 'package:get/get.dart';
import 'package:user_core2/model/claim.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/claim_service.dart';
import 'package:user_core2/util/dialog.dart';

class ClaimController extends GetxController {
  var isLoading = false.obs;
  var claimRequestBody = Rxn<ClaimRequestBody>();

  @override
  void onClose() {
    isLoading.value = false;
    claimRequestBody.value = null;
    super.onClose();
  }

  // 환뷸 굼액 정보 알림
  Future<void> showRefundAmountDialog(
      // 취소, 환불
      orderId,
      isCancelAll,
      claimType,
      reasonType,
      itemId,
      successMethod) async {
    try {
      isLoading.value = true;
      RefundResponse response = await ClaimServices.getRefundData(
          orderId, isCancelAll, claimType, reasonType, itemId);
      isLoading.value = false;
      if (response.status && response.data != null) {
        showConfirmDialog(response.message, successMethod);
      } else {
        response.message.isNotEmpty
            ? showBasicAlertDialog(response.message)
            : showErrorDialog();
      }
    } catch (err) {
      print('1: ${err}');
      isLoading.value = false;
      showErrorDialog();
    }
  }

  Future<void> sendCancelRequest(Function successMethod) async {
    if (isLoading.value || claimRequestBody.value == null) return;
    try {
      isLoading.value = true;
      BasicResponse response =
          await ClaimServices.requestClaim(claimRequestBody.value!);
      isLoading.value = false;
      if (response.status) {
        successMethod();
        return;
      } else {
        showBasicAlertDialog(response.message);
      }
    } catch (err) {
      print('2: ${err}');
      isLoading.value = false;
      showErrorDialog();
    }
  }
}
