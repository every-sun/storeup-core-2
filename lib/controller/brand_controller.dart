import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/controller/cart_controller.dart';
import 'package:user_core2/model/brand.dart';
import 'package:user_core2/model/order.dart';
import 'package:user_core2/service/brand_service.dart';
import 'package:user_core2/util/dialog.dart';

class BrandController extends GetxController {
  var isLoading = false.obs;
  var shippingFee = Rxn<ShippingFeeResponseData>();
  var carrier = Rxn<CarrierResponseData>();
  final dynamic brandId = Get.put(AppController()).appInfo.value!.brandId;
  CartController cartController = Get.put(CartController());

  @override
  void onInit() {
    print('BrandController2 onInit');

    setShippingFee();
    setCarrier();
    super.onInit();
  }

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  // 배송비 정보
  Future<void> setShippingFee() async {
    try {
      isLoading.value = true;
      ShippingFeeResponse response =
          await BrandServices.getShippingFee(brandId);
      isLoading.value = false;
      if (response.status && response.data != null) {
        shippingFee.value = response.data;
      } else {
        showBasicAlertDialog(response.message != ''
            ? response.message
            : '배송비 정보를 불러올 수 없습니다. 다시 시도해주세요.');
      }
    } catch (err) {
      showErrorDialog();
      isLoading.value = false;
      return;
    }
  }

  // 배송비 가져오기
  int getShippingFee() {
    if (shippingFee.value == null) return 0;
    if (shippingFee.value!.conditionType == 'P') {
      if (cartController.selectedCartsSumPrice.value >=
          shippingFee.value!.condition) {
        return shippingFee.value!.conditionFee;
      } else {
        // TODO 당일배달
        // if (orderType.value == 'N' &&
        //     (addressController.userDefaultAddress.value != null &&
        //         addressController.userDefaultAddress.value!.availableRegion!)) {
        //   return addressController.userDefaultAddress.value!.regionChargingFee!;
        // } else {
        //   return shippingFee.value!.defaultFee;
        // }
      }
    } else if (shippingFee.value!.conditionType == 'F') {
      return 0;
    }
    return 0;
  }

  // 택배 정보
  Future<void> setCarrier() async {
    try {
      isLoading.value = true;
      CarrierResponse response = await BrandServices.getCarrier(brandId);
      isLoading.value = false;
      if (response.status && response.data != null) {
        carrier.value = response.data;
      } else {
        showBasicAlertDialog(response.message != ''
            ? response.message
            : '택배 정보를 불러올 수 없습니다. 다시 시도해주세요.');
      }
    } catch (err) {
      showErrorDialog();
      isLoading.value = false;
      return;
    }
  }

  String? getCarrierValue() {
    if (carrier.value == null) return null;
    switch (carrier.value!.code) {
      case 'C1':
        return 'kr.epost';
      case 'C2':
        return 'kr.cjlogistics';
      case 'C3':
        return 'kr.logen';
      case 'C4':
        return 'kr.hanjin';
      case 'C5':
        return 'kr.lotte';
      case 'C6':
        return 'kr.daesin';
      case 'C7':
        return 'kr.ilyanglogis';
      case 'C8':
        return 'kr.kdexp';
      case 'C9':
        return 'de.dhl';
      case 'C10':
        return 'un.upu.ems';
      case 'C11':
        return 'us.fedex';
      case 'C12':
        return 'us.ups';
    }
    return null;
  }
}
