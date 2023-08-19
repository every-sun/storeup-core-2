import 'package:get/get.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/shipping_address.dart';
import 'package:user_core2/service/shipping_address_service.dart';
import 'package:user_core2/util/dialog.dart';

class ShippingAddressController extends GetxController {
  var isLoading = false.obs;
  var addresses = <ShippingAddress>[].obs;
  var dataHasMore = true.obs;
  var userDefaultAddress = Rxn<ShippingAddress>();
  var page = 1.obs;
  dynamic customerId = Get.find<UserController2>().customer.value != null
      ? Get.find<UserController2>().customer.value!.id
      : null;

  @override
  onInit() {
    getAddresses();
    super.onInit();
  }

  Future<bool> saveAddress(ShippingAddressRequestBody body) async {
    if (customerId == null) return false;
    try {
      isLoading.value = true;
      var response = await ShippingAddressServices2.storeShippingAddress(body);
      isLoading.value = false;
      if (response.status) {
        initAddresses();
        // await ShippingAddressServices2.getShippingAddresses(
        //         customerId, page.value)
        //     .then((res) async {
        //   addresses.clear();
        //   await getAddresses();
        //   // await getDefaultAddress();
        // });
        Get.back();
        showBasicAlertDialog(response.message);
      } else {
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      isLoading.value = false;
      showErrorDialog();
      return false;
    }
  }

  Future<bool> editAddress(
      dynamic addressId, ShippingAddressRequestBody body) async {
    if (customerId == null) return false;
    try {
      isLoading.value = true;
      var response =
          await ShippingAddressServices2.editShippingAddress(addressId, body);
      isLoading.value = false;
      if (response.status) {
        initAddresses();
        // addresses.clear();
        // await getAddresses();
        // await getDefaultAddress();
        // isLoading.value = false;
        Get.back();
        showBasicAlertDialog(response.message);
      } else {
        isLoading.value = false;
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      isLoading.value = false;
      showErrorDialog();
      return false;
    }
  }

  Future<bool> getAddresses() async {
    if (customerId == null) return false;
    try {
      isLoading.value = true;
      ShippingAddressResponse response =
          await ShippingAddressServices2.getShippingAddresses(
              customerId, page.value);
      isLoading.value = false;
      if (response.status) {
        if (response.data.data.isEmpty) {
          dataHasMore.value = false;
        } else {
          addresses.addAll(response.data.data);
          page.value++;
        }
      } else {
        dataHasMore.value = false;
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      isLoading.value = false;
      showErrorDialog();
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
    if (customerId == null) return false;
    try {
      isLoading.value = true;
      var response =
          await ShippingAddressServices2.setDefaultShippingAddress(address.id);
      isLoading.value = false;
      if (response.status) {
        userDefaultAddress.value = address;
        initAddresses();
      } else {
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      isLoading.value = false;
      showErrorDialog();
      return false;
    }
  }

  Future<bool> deleteAddress(dynamic addressId) async {
    if (customerId == null) return false;
    try {
      isLoading.value = true;
      BasicResponse response =
          await ShippingAddressServices2.deleteShippingAddress(addressId);
      isLoading.value = false;
      if (response.status) {
        initAddresses();
      } else {
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      isLoading.value = false;
      showErrorDialog();
      return false;
    }
  }

  Future<bool> getDefaultAddress() async {
    if (customerId == null) return false;
    try {
      isLoading.value = true;
      var response =
          await ShippingAddressServices2.getDefaultShippingAddress(customerId);
      isLoading.value = false;
      if (response.status && response.data != null) {
        userDefaultAddress.value = response.data;
      } else {
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      print(err);
      isLoading.value = false;
      return false;
    }
  }
}
