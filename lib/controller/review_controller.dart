import 'dart:convert';
import 'package:get/get.dart';
import 'package:user_core2/controller/image_controller.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/service/review_service.dart';
import 'package:user_core2/service/service.dart';
import 'package:user_core2/util/dialog.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/review.dart';
import 'package:http/http.dart' as http;

class ReviewController extends GetxController {
  UserController userController = Get.put(UserController());
  ImageController imageController = Get.put(ImageController());
  var isLoading = false.obs;

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  Future<bool> saveReview(ReviewRequestBody body) async {
    try {
      if (isLoading.value) return false;
      isLoading.value = true;
      var request = http.MultipartRequest(
          "POST",
          Uri.parse(
              '${ServiceAPI.baseUrl}/customers/${userController.customer.value!.id}/reviews/store'));
      request.headers.addAll(ServiceAPI.headerInfo);
      request.fields.addAll(body.toJson());

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
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('리뷰 작성에 실패하였습니다.');
      return false;
    }
  }

  Future<bool> updateReview(id, contents) async {
    try {
      if (isLoading.value) return false;
      isLoading.value = true;
      var request = http.MultipartRequest(
          "POST",
          Uri.parse(
              '${ServiceAPI.baseUrl}/customers/${userController.customer.value!.id}/reviews/edit/$id'));
      request.headers.addAll(ServiceAPI.headerInfo);
      request.fields.addAll({
        '_method': 'PUT',
        'contents': contents,
      });
      for (var i = 0; i < imageController.deleteImagesId.length; i++) {
        request.fields.addAll(
            {'delete_images_id[$i]': imageController.deleteImagesId[i]});
      }
      for (var i = 0; i < imageController.images.length; i++) {
        var filePath = imageController.images[i].path;
        var file = await http.MultipartFile.fromPath('images[$i]', filePath);
        request.files.add(file);
      }
      var result = await request.send();
      final resultResponse = await http.Response.fromStream(result);

      isLoading.value = false;
      BasicResponse response =
          BasicResponse.fromJson(jsonDecode(resultResponse.body));
      if (!response.status) {
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('리뷰 수정을 실패하였습니다.');
      return false;
    }
  }

  Future<void> deleteReview(id, successMethod) async {
    try {
      isLoading.value = true;
      BasicResponse response = await ReviewServices2.deleteReview(
          userController.customer.value!.id, id);
      isLoading.value = false;
      if (response.status) {
        successMethod();
      } else {
        showBasicAlertDialog(response.message);
      }
      return;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('리뷰 삭제에 실패하였습니다.');
      return;
    }
  }
}
