import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/model/board.dart';
import 'package:user_core2/service/board_service.dart';
import 'package:user_core2/util/dialog.dart';

class BoardController extends GetxController {
  var isLoading = false.obs;

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  // 이벤트 또는 공지사항 게시판 불러오기
  Future<void> getBoard(type, successMethod) async {
    try {
      Board? response = await BoardServices.getBoard(
          Get.find<AppController>().appInfo.value!.brandId, type);
      if (response != null && response.isDisplay) {
        successMethod(response);
      } else {
        showBasicAlertDialog('${type == 'N' ? '공지사항' : '이벤트'} 게시판이 존재하지 않습니다.');
      }
    } catch (err) {
      showBasicAlertDialog(
          '${type == 'N' ? '공지사항' : '이벤트'} 게시판을 불러오는데 실패하였습니다.');
    }
  }
}
