import 'package:get/get.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/shipping_address.dart';
import 'package:user_core2/service/shipping_address_service.dart';
import 'package:user_core2/util/dialog.dart';

class ShippingAddressController extends GetxController {
  final UserController userController = Get.find<UserController>();

  var isLoading = false.obs;
  var addresses = <ShippingAddress>[].obs;
  var dataHasMore = true.obs;
  var userDefaultAddress = Rxn<ShippingAddress>();
  var page = 1.obs;

  @override
  void onInit() {
    getDefaultAddress();
    getAddresses();
    super.onInit();
  }

  @override
  void onClose() {
    isLoading.value = false;
    initAddresses();
    super.onClose();
  }

  Future<bool> saveAddress(ShippingAddressRequestBody body) async {
    try {
      isLoading.value = true;
      var response = await ShippingAddressServices2.storeShippingAddress(body);
      isLoading.value = false;
      if (response.status) {
        await getDefaultAddress();
        initAddresses();
        getAddresses();
        Get.back();
        showBasicAlertDialog(response.message);
      } else {
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('배송지를 저장하는데 실패하였습니다.');
      return false;
    }
  }

  Future<bool> editAddress(
      dynamic addressId, ShippingAddressRequestBody body) async {
    try {
      isLoading.value = true;
      var response =
          await ShippingAddressServices2.editShippingAddress(addressId, body);
      isLoading.value = false;
      if (response.status) {
        await getDefaultAddress();
        initAddresses();
        getAddresses();
        Get.back();
        showBasicAlertDialog(response.message);
      } else {
        isLoading.value = false;
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('배송지를 수정하는데 실패하였습니다.');
      return false;
    }
  }

  Future<bool> getAddresses() async {
    if (userController.customer.value == null) return false;
    try {
      isLoading.value = true;
      ShippingAddressResponse response =
          await ShippingAddressServices2.getShippingAddresses(
              userController.customer.value!.id, page.value);
      dataHasMore.value = false;
      isLoading.value = false;
      if (response.status && response.data != null) {
        if (response.data!.data.isEmpty) {
          dataHasMore.value = false;
        } else {
          addresses.addAll(response.data!.data);
          page.value++;
        }
      } else {
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('배송지를 가져오는데 실패하였습니다.');
      return false;
    }
  }

  void initAddresses() {
    addresses.clear();
    isLoading.value = false;
    dataHasMore.value = true;
    page.value = 1;
  }

  Future<bool> setDefaultAddress(ShippingAddress address) async {
    try {
      isLoading.value = true;
      var response =
          await ShippingAddressServices2.setDefaultShippingAddress(address.id);
      isLoading.value = false;
      if (response.status) {
        userDefaultAddress.value = address;
        initAddresses();
        getAddresses();
      } else {
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('기본 배송지를 설정하는데 실패하였습니다.');
      return false;
    }
  }

  Future<bool> deleteAddress(dynamic addressId) async {
    try {
      isLoading.value = true;
      BasicResponse response =
          await ShippingAddressServices2.deleteShippingAddress(addressId);
      isLoading.value = false;
      if (response.status) {
        initAddresses();
        getAddresses();
      } else {
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('배송지를 삭제하는데 실패하였습니다.');
      return false;
    }
  }

  Future<bool> getDefaultAddress() async {
    if (userController.customer.value == null) return false;
    try {
      isLoading.value = true;
      var response = await ShippingAddressServices2.getDefaultShippingAddress(
          userController.customer.value!.id);
      isLoading.value = false;
      if (response.status && response.data != null) {
        userDefaultAddress.value = response.data;
      }
      return response.status;
    } catch (err) {
      isLoading.value = false;
      return false;
    }
  }
}
