import 'package:get/get.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/service/stamp_service.dart';
import 'package:user_core2/util/dialog.dart';

class StampController extends GetxController {
  var answer = ''.obs;
  var completeList = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    getCompleteList();
    super.onInit();
  }

  @override
  void onClose() {
    isLoading.value = false;
    answer.value = '';
    super.onClose();
  }

  Future<void> getCompleteList() async {
    try {
      isLoading.value = true;
      Map response = await StampServices.getStamps(
          Get.find<UserController>().customer.value!.id);
      isLoading.value = false;
      if (response['status'] && response['data'] != null) {
        completeList.assignAll(response['data']['stamp_list']);
      } else {
        showBasicAlertDialog(response['message'] ?? '');
      }
    } catch (err) {
      showBasicAlertDialog('완료한 문제를 조회하는데 실패하였습니다.');
      isLoading.value = false;
    }
  }
}
