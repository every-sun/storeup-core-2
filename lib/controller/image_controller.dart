import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_core2/util/dialog.dart';

class ImageController extends GetxController {
  var images = <XFile>[].obs;
  final ImagePicker _picker = ImagePicker();
  var existingImages = <dynamic>[].obs; // 리뷰 수정시 기존의 사진들

  Future<void> pickImage(int maximum) async {
    try {
      int count = maximum - (existingImages.length + images.length);
      final List<XFile> pickedImage = await _picker.pickMultiImage();
      if (pickedImage.isNotEmpty) {
        for (var i = 0; i < count; i++) {
          images.add(pickedImage[i]);
        }
      }
      if (pickedImage.length > count) {
        showBasicAlertDialog('이미지는 총 $maximum장까지 등록 가능합니다.');
      }
    } catch (err) {
      return;
    }
  }
}
