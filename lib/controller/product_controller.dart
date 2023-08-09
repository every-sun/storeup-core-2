import 'package:get/get.dart';

class ProductController2 extends GetxController {
  var isLoading = false.obs;
  var sortValue = 'created_at'.obs;
  var sortDescending = 'DESC'.obs; // ASC: 오름차순, DESC: 내림차순
  var productCount = 0.obs;
  var page = 1.obs;

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  void sortProducts(value) {
    if (value == '최신순') {
      sortValue.value = 'created_at';
      sortDescending.value = 'DESC';
    } else if (value == '상품명순') {
      sortValue.value = 'name';
      sortDescending.value = 'ASC';
    } else if (value == '낮은가격순') {
      sortValue.value = 'price';
      sortDescending.value = 'ASC';
    } else if (value == '높은가격순') {
      sortValue.value = 'price';
      sortDescending.value = 'DESC';
    }
  }
}
