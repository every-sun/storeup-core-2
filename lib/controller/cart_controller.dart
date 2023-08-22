import 'package:get/get.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/cart.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/product.dart';
import 'package:user_core2/service/cart_service.dart';
import 'package:user_core2/util/dialog.dart';

class CartController2 extends GetxController {
  UserController2 userController = Get.put(UserController2());
  var isLoading = false.obs;
  var selectedCarts = <Cart>[].obs;
  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  Map<String, List<ProductOption>> getDividedOption(
      List<ProductOption> options) {
    // 옵션을 필수옵션, 선택옵션 분리한 Map을 리턴
    Map<String, List<ProductOption>> result = {'required': [], 'optional': []};
    for (var i = 0; i < options.length; i++) {
      if (options[i].min > 0) {
        result['required']!.add(options[i]);
      } else {
        result['optional']!.add(options[i]);
      }
    }
    return result;
  }

  /* 장바구니 담을 때 필수옵션이 다 선택되었는지 확인 */
  bool checkRequiredOptions(List<ProductOption> requiredOptions,
      List<CartOption> selectRequiredOptions) {
    bool result = true;
    for (var i = 0; i < requiredOptions.length; i++) {
      if (requiredOptions[i].min >
          selectRequiredOptions[i].childrenOptions.length) {
        result = false;
        break;
      }
    }
    return result;
  }

  String getOptionSelectQuantity(min, max) {
    if (min == 0) {
      if (max == 0) {
        return '';
      } else {
        return '최대 $max개';
      }
    } else {
      if (min == max) {
        return '$min개';
      } else {
        if (min == 1) {
          if (max == 0) {
            return '최소 1개';
          } else {
            return '최대 $max개';
          }
        } else {
          if (max == 0) {
            return '최소 $min개';
          } else {
            return '최소 $min개 / 최대 $max개';
          }
        }
      }
    }
  }

  /* 장바구니 담을 때 필수옵션이 다 선택되었는지 확인 */
  bool isCheckRequiredSelected(List<ProductOption> options, requiredOptions) {
    for (var i = 0; i < options.length; i++) {
      if (requiredOptions
              .where((child) => child.parentId == options[i].id)
              .length <
          options[i].min) {
        return false;
      }
    }
    return true;
  }

  Future<bool> saveCartItem(CartRequestBody body) async {
    if (userController.customer.value == null) return false;
    try {
      isLoading.value = true;
      BasicResponse response = await CartServices2.storeCart(
          userController.customer.value!.id, body);
      isLoading.value = false;
      if (!response.status) {
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      showErrorDialog();
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> deleteCarts(List<dynamic> cartIdList) async {
    if (userController.customer.value == null) return false;
    try {
      isLoading.value = true;
      BasicResponse response = await CartServices2.deleteCarts(
          userController.customer.value!.id, cartIdList);
      isLoading.value = false;
      if (!response.status) {
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      print(err);
      showErrorDialog();
      isLoading.value = false;
      return false;
    }
  }
}
