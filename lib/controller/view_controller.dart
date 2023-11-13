import 'package:get/get.dart';

class ViewController extends GetxController {
  RxString currentTab = ''.obs;
  RxBool isBottomTabMenuVisible = true.obs;
  void setCurrentTab(current) {
    currentTab.value = current;
  }
}
