import 'package:get/get.dart';
import 'package:user_core2/model/claim.dart';
import 'package:user_core2/service/claim_service.dart';
import 'package:user_core2/util/dialog.dart';

class ClaimController extends GetxController {
  var isLoading = false.obs;

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  Future<void> showRefundAmountDialog(
      orderId, isCancelAll, claimType, reasonType, itemId) async {
    try {
      isLoading.value = true;
      RefundResponse response = await ClaimServices.getRefundData(
          orderId, isCancelAll, claimType, reasonType, itemId);
      isLoading.value = false;
      if (response.status && response.data != null) {
        showBasicAlertDialog(response.message);
      } else {
        response.message.isNotEmpty
            ? showBasicAlertDialog(response.message)
            : showErrorDialog();
      }
    } catch (err) {
      isLoading.value = false;
      showErrorDialog();
    }
  }
}
