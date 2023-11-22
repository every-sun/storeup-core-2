import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/cart.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/product.dart';
import 'package:user_core2/service/cart_service.dart';
import 'package:user_core2/util/dialog.dart';
import 'package:user_core2/util/product_check.dart';

class CartController extends GetxController {
  var isLoading = false.obs;
  var selectedCarts = <Cart>[].obs;
  var selectedCartsSumPrice = 0.obs;
  var total = 0.obs;
  var deliveryTotal = 0.obs;
  var nowTypeTotal = 0.obs;
  var onlineTypeTotal = 0.obs;

  @override
  onInit() {
    getCartTotal('O');
    if (Get.find<AppController>().appInfo.value!.brandId == 2) {
      getCartTotal('D');
    }
    super.onInit();
  }

  Future<void> getCartTotalByProductType(type) async {
    try {
      CartResponse response = await CartServices2.getCarts(
          Get.find<UserController>().customer.value!.id, type, 1, 0);
      if (response.status && response.data != null) {
        if (type == 'N') {
          nowTypeTotal.value = response.data!.total;
        } else {
          onlineTypeTotal.value = response.data!.total;
        }
      }
      return;
    } catch (err) {
      return;
    }
  }

  Future<void> getCartTotal(type) async {
    try {
      if (Get.find<UserController>().customer.value == null) {
        total.value = 0;
        deliveryTotal.value = 0;
      } else {
        int count = await CartServices2.getCartTotal(
            Get.find<UserController>().customer.value!.id, type);
        if (type == 'O') {
          total.value = count;
        } else if (type == 'D') {
          deliveryTotal.value = count;
        }
      }
      return;
    } catch (err) {
      return;
    }
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

  void updatePrice() {
    int result = 0;
    for (var i = 0; i < selectedCarts.length; i++) {
      result += (selectedCarts[i].optionPrice + selectedCarts[i].productPrice) *
          selectedCarts[i].quantity;
    }
    selectedCartsSumPrice.value = result;
  }

  Future<BasicResponse?> saveCartItem(CartRequestBody body) async {
    if (Get.find<UserController>().customer.value == null) return null;
    try {
      isLoading.value = true;
      BasicResponse response = await CartServices2.storeCart(
          Get.find<UserController>().customer.value!.id, body);
      isLoading.value = false;
      if ((body.cartType == 'O' || body.cartType == 'N')) {
        if (response.status) {
          await getCartTotal('O');
        } else {
          showBasicAlertDialog(response.message);
        }
      }
      if (body.cartType == 'D' && response.status) {
        await getCartTotal('D');
      }
      return response;
    } catch (err) {
      showBasicAlertDialog('장바구니에 담는데 실패하였습니다.');
      isLoading.value = false;
      return null;
    }
  }

  Future<bool> deleteCarts(List<dynamic> cartIdList, successMethod) async {
    if (Get.find<UserController>().customer.value == null) return false;
    try {
      isLoading.value = true;
      BasicResponse response = await CartServices2.deleteCarts(
          Get.find<UserController>().customer.value!.id, cartIdList);
      isLoading.value = false;
      if (!response.status) {
        showBasicAlertDialog(response.message);
      } else {
        await getCartTotal('O');
        await getCartTotal('D');
        successMethod();
      }
      return response.status;
    } catch (err) {
      showBasicAlertDialog('장바구니를 삭제하는데 실패하였습니다.');
      isLoading.value = false;
      return false;
    }
  }

  void check(isAdd, Cart cart) {
    if (cartOutOfStockType(cart) != '') {
      return;
    }
    if (isAdd) {
      selectedCarts.add(cart);
    } else {
      selectedCarts.removeWhere((element) => element.id == cart.id);
    }
    updatePrice();
  }

  void checkAll(carts) {
    if (selectedCarts.isEmpty) {
      List<Cart> values = [];
      for (var i = 0; i < carts.length; i++) {
        if (cartOutOfStockType(carts[i]) == '') {
          values.add(carts[i]);
        }
      }
      selectedCarts.assignAll(values);
    } else {
      selectedCarts.clear();
    }
    updatePrice();
  }

  Future<void> deleteUnableCarts(List<Cart> carts, refreshMethod) async {
    List<dynamic> targets = [];
    for (var i = 0; i < carts.length; i++) {
      if (cartOutOfStockType(carts[i]) != '') {
        targets.add(carts[i].id);
      }
    }
    if (targets.isEmpty) {
      showBasicAlertDialog('품절 또는 구매 불가능한 상품이 없습니다.');
      return;
    }
    isLoading.value = true;
    await deleteCarts(targets, refreshMethod);
    isLoading.value = false;
  }

  Future<void> updateQuantity(
      isAdd, dynamic cartId, carts, quantity, successMethod) async {
    try {
      BasicResponse response = await CartServices2.updateQuantity(
          Get.find<UserController>().customer.value!.id, cartId, quantity);
      if (response.status) {
        successMethod();
        updatePrice();
      } else {
        showBasicAlertDialog(response.message);
      }
    } catch (err) {
      showBasicAlertDialog('수량 조절을 실패하였습니다.');
      return;
    }
  }

  Future<void> changeCartType(
      List<dynamic> idList, Function successMethod, type) async {
    try {
      isLoading.value = true;
      BasicResponse response = await CartServices2.changeCartType(
          Get.find<UserController>().customer.value!.id,
          {'from': type, 'items': idList});
      isLoading.value = false;
      if (response.status) {
        successMethod();
      } else {
        showBasicAlertDialog(response.message);
      }
      await getCartTotalByProductType('O');
      await getCartTotalByProductType('N');
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('배송 방법 변경을 실패하였습니다.');
      return;
    }
  }

  void initStates() {
    isLoading.value = false;
    selectedCarts.clear();
    selectedCartsSumPrice.value = 0;
  }
}
