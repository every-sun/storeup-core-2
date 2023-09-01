import 'package:get/get.dart';
import 'package:user_core2/model/product.dart';
import 'package:user_core2/service/product_service.dart';
import 'package:user_core2/util/dialog.dart';

class ProductController2 extends GetxController {
  var sortValue = 'created_at'.obs;
  var sortDescending = 'DESC'.obs; // ASC: 오름차순, DESC: 내림차순
  // var page = 1.obs;

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

  Future<Product?> getProduct(productId) async {
    try {
      Product product = await ProductServices2.getProduct(productId, 'O');
      return product;
    } catch (err) {
      Get.back();
      showBasicAlertDialog('상품 정보를 불러올 수 없습니다.');
      return null;
    }
  }
}
