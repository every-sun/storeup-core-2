import 'dart:convert';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:user_core2/controller/image_controller.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/inquiry.dart';
import 'package:user_core2/service/inquiry_service.dart';
import 'package:user_core2/service/service.dart';
import 'package:user_core2/util/dialog.dart';
import 'package:user_core2/model/language.dart';
import 'package:http/http.dart' as http;

class InquiryController extends GetxController {
  ImageController imageController = Get.put(ImageController());
  var isLoading = false.obs;

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  Future<void> saveInquiry(
      InquiryRequestBody body, Function successMethod) async {
    try {
      if (isLoading.value) return;
      isLoading.value = true;
      var request = http.MultipartRequest(
          "POST",
          Uri.parse(
              '${ServiceAPI().baseUrl}/customers/${Get.find<UserController>().customer.value!.id}/inquiries/store'));
      request.headers.addAll(ServiceAPI().headerInfo);
      request.fields.addAll(body.toJson());

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
      return;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('문의 작성에 실패하였습니다.');
      return;
    }
  }

  Future<void> editInquiry(
      dynamic id, title, contents, isPrivate, successMethod) async {
    try {
      if (isLoading.value) return;
      isLoading.value = true;
      BasicResponse response = await InquiryServices.editInquiry(
          Get.find<UserController>().customer.value!.id,
          id,
          title,
          contents,
          isPrivate);
      isLoading.value = false;
      if (response.status) {
        successMethod();
      } else {
        showBasicAlertDialog(response.message);
      }
      return;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('문의 수정에 실패하였습니다.');
      return;
    }
  }

  Future<void> deleteInquiry(dynamic id, Function successMethod) async {
    try {
      if (isLoading.value) return;
      isLoading.value = true;
      BasicResponse response = await InquiryServices.deleteInquiry(
          Get.find<UserController>().customer.value!.id, id);
      isLoading.value = false;
      if (response.status) {
        successMethod();
      } else {
        showBasicAlertDialog(response.message);
      }
      return;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('문의 삭제에 실패하였습니다.');
      return;
    }
  }
}
