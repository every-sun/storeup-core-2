import 'dart:convert';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:user_core2/controller/image_controller.dart';
import 'package:user_core2/model/claim.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/claim_service.dart';
import 'package:user_core2/service/service.dart';
import 'package:user_core2/util/dialog.dart';
import 'package:http/http.dart' as http;

class ClaimController extends GetxController {
  var isLoading = false.obs;
  var claimRequestBody = Rxn<ClaimRequestBody>();
  ImageController imageController = Get.put(ImageController());

  @override
  void onClose() {
    print('ClaimController onClose');

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
      isLoading.value = false;
      showErrorDialog();
    }
  }

  Future<void> sendExchangeRefundRequest(
      orderNo, Function successMethod) async {
    if (isLoading.value || claimRequestBody.value == null) return;
    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse('${ServiceAPI().baseUrl}/claims'));
      request.headers.addAll(ServiceAPI().headerInfo);
      request.fields.addAll({
        'order_id': claimRequestBody.value!.orderId,
        'is_cancel_all': false.toString(),
        'item_id': claimRequestBody.value!.itemId,
        'claim_type': claimRequestBody.value!.claimType,
        'claim_reason_type': claimRequestBody.value!.claimReasonType,
        'claim_subject': claimRequestBody.value!.claimSubject,
        'quantity': claimRequestBody.value!.quantity.toString(),
      });
      if (claimRequestBody.value!.pickup != null) {
        request.fields.addAll({
          'pickup[name]': claimRequestBody.value!.pickup!['name'] ?? '',
          'pickup[contact]': claimRequestBody.value!.pickup!['contact'] ?? '',
          'pickup[address1]': claimRequestBody.value!.pickup!['address1'] ?? '',
          'pickup[address2]': claimRequestBody.value!.pickup!['address2'] ?? '',
          'pickup[zipcode]': claimRequestBody.value!.pickup!['zipcode'] ?? '',
        });
      }
      for (var i = 0; i < imageController.images.length; i++) {
        var filePath = imageController.images[i].path;
        var lastIndex = filePath.lastIndexOf(RegExp(r'jp'));
        var split = filePath.substring(0, (lastIndex - 1));
        var outPath = '${split}_out${filePath.substring(lastIndex - 1)}';

        var result = await FlutterImageCompress.compressAndGetFile(
            filePath, outPath,
            minHeight: 600, minWidth: 600, quality: 70);

        var file =
            await http.MultipartFile.fromPath('images[$i]', result!.path);
        request.files.add(file);
      }

      if (claimRequestBody.value!.claimType == 'R') {
        // 반품
        showRefundAmountDialog(
            claimRequestBody.value!.orderId,
            claimRequestBody.value!.isCancelAll,
            claimRequestBody.value!.claimType,
            claimRequestBody.value!.claimReasonType,
            claimRequestBody.value!.itemId, () async {
          isLoading.value = true;
          var result = await request.send();
          final resultResponse = await http.Response.fromStream(result);
          isLoading.value = false;
          BasicResponse response =
              BasicResponse.fromJson(jsonDecode(resultResponse.body));
          if (!response.status) {
            showBasicAlertDialog(response.message);
          } else {
            successMethod();
          }
        });
      }
    } catch (err) {
      isLoading.value = false;
      showErrorDialog();
    }
  }
}
