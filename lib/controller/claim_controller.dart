import 'dart:convert';
import 'package:get/get.dart';
import 'package:user_core2/controller/image_controller.dart';
import 'package:user_core2/model/claim.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/claim_service.dart';
import 'package:user_core2/service/service.dart';
import 'package:user_core2/util/dialog.dart';
import 'package:http/http.dart' as http;

class ClaimController extends GetxController {
  ImageController imageController = Get.put(ImageController());
  var isLoading = false.obs;
  var claimRequestBody = ClaimRequestBody(
          reShipping: null,
          orderId: '',
          itemId: '',
          isCancelAll: false,
          claimType: '',
          claimSubject: 'C',
          quantity: 0,
          claimReason: '',
          claimReasonType: '',
          pickup: null)
      .obs;
  var shippingRequest = '회수 장소 선택'.obs; // 회수 장소 (문 앞, 경비실 등)

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  void initState() {
    isLoading.value = false;
    shippingRequest.value = '회수 장소 선택';
    claimRequestBody.value = ClaimRequestBody(
        reShipping: null,
        orderId: '',
        isCancelAll: false,
        itemId: '',
        claimType: '',
        claimReasonType: '',
        claimSubject: 'C',
        quantity: 0,
        claimReason: '',
        pickup: null);
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
        Get.close(1);
        showBasicAlertDialog(response.message);
      }
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('환불금액 정보 조회에 실패하였습니다.');
    }
  }

  Future<void> sendCancelRequest(Function successMethod) async {
    if (isLoading.value) return;
    try {
      isLoading.value = true;
      BasicResponse response =
          await ClaimServices.requestClaim(claimRequestBody.value);
      isLoading.value = false;
      if (response.status) {
        successMethod();
        return;
      } else {
        Get.close(1);
        showBasicAlertDialog(response.message);
      }
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('주문 취소 요청을 실패하였습니다.');
    }
  }

  Future<void> sendExchangeRefundRequest(Function successMethod) async {
    if (isLoading.value) return;
    try {
      isLoading.value = true;

      var request = http.MultipartRequest(
          "POST", Uri.parse('${ServiceAPI.baseUrl}/claims'));
      request.headers.addAll(ServiceAPI.headerInfo);
      request.fields.addAll({
        'order_id': claimRequestBody.value.orderId,
        'item_id': claimRequestBody.value.itemId,
        'is_cancel_all': false.toString(),
        'claim_type': claimRequestBody.value.claimType,
        'claim_reason_type': claimRequestBody.value.claimReasonType,
        'claim_subject': 'C',
        'quantity': claimRequestBody.value.quantity.toString(),
        'claim_reason': claimRequestBody.value.claimReason
      });
      if (claimRequestBody.value.pickup != null) {
        request.fields.addAll({
          'pickup[name]': claimRequestBody.value.pickup!['name'] ?? '',
          'pickup[contact]': claimRequestBody.value.pickup!['contact'] ?? '',
          'pickup[address1]': claimRequestBody.value.pickup!['address1'] ?? '',
          'pickup[address2]': claimRequestBody.value.pickup!['address2'] ?? '',
          'pickup[zipcode]': claimRequestBody.value.pickup!['zipcode'] ?? '',
          'pickup[pickup_type]': 'B',
          'pickup[pickup_request]':
              claimRequestBody.value.pickup!['pickup_request'] ?? '',
        });
      } else {
        request.fields.addAll({
          'pickup[pickup_type]': 'C',
        });
      }
      if (claimRequestBody.value.claimType == 'E' &&
          claimRequestBody.value.reShipping != null) {
        request.fields.addAll({
          're_shipping[address1]':
              claimRequestBody.value.reShipping!['address1'] ?? '',
          're_shipping[address2]':
              claimRequestBody.value.reShipping!['address2'] ?? '',
          're_shipping[zipcode]':
              claimRequestBody.value.reShipping!['zipcode'] ?? '',
        });
      }
      for (var i = 0; i < imageController.images.length; i++) {
        var filePath = imageController.images[i].path;
        // var lastIndex = filePath.lastIndexOf(RegExp(r'jp'));
        // var split = filePath.substring(0, (lastIndex - 1));
        // var outPath = '${split}_out${filePath.substring(lastIndex - 1)}';
        //
        // var result = await FlutterImageCompress.compressAndGetFile(
        //     filePath, outPath,
        //     minHeight: 600, minWidth: 600, quality: 70);
        var file = await http.MultipartFile.fromPath('images[$i]', filePath);
        request.files.add(file);
      }
      var result = await request.send();
      final resultResponse = await http.Response.fromStream(result);
      isLoading.value = false;
      BasicResponse response =
          BasicResponse.fromJson(jsonDecode(resultResponse.body));
      if (!response.status) {
        Get.close(1);
        showBasicAlertDialog(response.message);
      } else {
        successMethod();
      }
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('요청에 실패하였습니다.');
    }
  }

  Future<void> cancelClaim(id, successMethod) async {
    try {
      isLoading.value = true;
      BasicResponse response = await ClaimServices.cancelClaim(id);
      isLoading.value = false;

      if (response.status) {
        successMethod();
      } else {
        showBasicAlertDialog(response.message);
      }
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('신청을 철회하는데 실패하였습니다.');
    }
  }
}
