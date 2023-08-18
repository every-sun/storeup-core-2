// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:user_core2/controller/user_controller.dart';
// import 'package:user_core2/model/shipping_address.dart';
// import 'package:user_core2/service/shipping_address_service.dart';
// import 'package:user_core2/util/dialog.dart';
//
// class AddressController extends GetxController {
//   var isLoading = false.obs;
//   var addresses = <ShippingAddress>[].obs;
//   var userDefaultAddress = Rxn<ShippingAddress>();
//   var page = 1.obs;
//   String? customerId = Get.find<UserController2>().customer.value != null
//       ? Get.find<UserController2>().customer.value!.id
//       : null;
//
//   @override
//   onInit() {
//     getAddresses();
//     super.onInit();
//   }
//
//   Future<bool> saveAddress(ShippingAddressRequestBody body) async {
//     if (customerId == null) return false;
//     isLoading.value = true;
//     try {
//       if (addresses.isEmpty) {
//         body.isDefaultAddress = true;
//       }
//       var response = await ShippingAddressServices2.storeShippingAddress(body);
//       if (response.status) {
//         await ShippingAddressServices2.getShippingAddresses(
//                 customerId, page.value)
//             .then((res) async {
//           addresses.clear();
//           await getAddresses();
//           await getDefaultAddress();
//         });
//       } else {
//         isLoading.value = false;
//         return false;
//       }
//       isLoading.value = false;
//       return true;
//     } catch (err) {
//       isLoading.value = false;
//       return false;
//     }
//   }
//
//   Future<void> getAddresses() async {
//     if (customerId == null) return;
//     try {
//       isLoading.value = true;
//       List<ShippingAddress> list = [];
//
//       await FirebaseFirestore.instance
//           .collection("shipping_address")
//           .where("customer_id", isEqualTo: customerId)
//           .get()
//           .then((snapshot) {
//         for (var doc in snapshot.docs) {
//           list.add(ShippingAddress.fromJson(doc.data()));
//         }
//         if (addresses.length != list.length) {
//           addresses.value = list;
//         }
//       });
//       List<ShippingAddress> object =
//           list.where((element) => element.isDefaultAddress == true).toList();
//       if (object.isNotEmpty) {
//         list.removeWhere((element) => element.id == object[0].id);
//         list.insert(0, object[0]);
//       }
//       isLoading.value = false;
//     } catch (err) {
//       print(err);
//       showErrorDialog();
//       isLoading.value = false;
//     }
//     return;
//   }
//
//   Future<bool> editAddress(
//       String addressId, ShippingAddressRequestBody body) async {
//     if (customerId == null) return false;
//     isLoading.value = true;
//     try {
//       var response =
//           await ShippingAddressServices2.editShippingAddress(addressId, body);
//       if (response.status) {
//         await AddressServices.getAvailableAddress(
//                 Get.find<AppController>().appInfo.value!.brandTenantId,
//                 addressId)
//             .then((res) async {
//           addressList.clear();
//           await getAddresses();
//           await getDefaultAddress();
//         });
//       } else {
//         isLoading.value = false;
//         return false;
//       }
//       isLoading.value = false;
//       return true;
//     } catch (err) {
//       isLoading.value = false;
//       return false;
//     }
//   }
//
//   Future<int?> setDefaultAddress(String addressId) async {
//     if (customerId == null) return null;
//     isLoading.value = true;
//     var response =
//         await ShippingAddressServices2.setDefaultShippingAddress(addressId);
//     if (response.status) {
//       addresses.clear();
//       await getAddresses();
//       await getDefaultAddress();
//     }
//     userDefaultAddress.value = response.item;
//     isLoading.value = false;
//     return response.status;
//   }
//
//   Future<void> deleteAddress(Address address) async {
//     if (customerId == null) return;
//     if (address.defaultAddress) {
//       showBasicAlertDialog('기본배송지는 삭제할 수 없습니다.');
//       return;
//     }
//     isLoading.value = true;
//     await FirebaseFirestore.instance
//         .collection("shipping_address")
//         .doc(address.id)
//         .delete();
//     addressList.clear();
//     await getAddresses();
//     await getDefaultAddress();
//     isLoading.value = false;
//   }
//
//   Future<void> getDefaultAddress() async {
//     try {
//       isLoading.value = true;
//       var response =
//           await ShippingAddressServices2.getDefaultAddress(customerId);
//       userDefaultAddress.value = response;
//       isLoading.value = false;
//     } catch (err) {
//       print(err);
//       isLoading.value = false;
//     }
//     return;
//   }
// }
