import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/service/auth_service.dart';
import 'package:user_core2/model/auth.dart';
import 'package:user_core2/util/dialog.dart';

class AuthController2 extends GetxController {
  var isLoading = false.obs;
  var registerRequestBody = Rxn<RegisterRequestBody>();

  @override
  void onInit() {
    initRegisterRequestBody();
    super.onInit();
  }

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  void initRegisterRequestBody() {
    registerRequestBody.value = RegisterRequestBody(
      data: RegisterRequestBodyData(
          email: '',
          password: '',
          passwordConfirmation: '',
          name: '',
          brandId: 0,
          contact: '',
          termsAndConditions: true,
          personalInformation: true,
          over14YearsOld: true,
          serviceNotification: false,
          nighttimeServiceNotification: false,
          marketingNotification: false,
          gender: 'M',
          residence1: '',
          residence2: '',
          birthDay: ''),
      flag: '',
      authUid: null,
    );
  }

  Future<bool> register() async {
    if (registerRequestBody.value == null) return false;
    try {
      isLoading.value = true;
      registerRequestBody.value!.data.brandId =
          Get.find<AppController2>().appInfo.value!.brandId;
      var result = await AuthServices2.register(registerRequestBody.value!);
      if (!result.status) {
        showBasicAlertDialog(result.message);
      } else {
        initRegisterRequestBody();
        Get.to(() => Get.find<AppController2>().appInfo.value!.loginPage);
        showBasicAlertDialog(result.message);
      }
      isLoading.value = false;
      return result.status;
    } catch (err) {
      showErrorDialog();
      isLoading.value = false;
      return false;
    }
  }

  Future<LoginResponse?> login(LoginRequestBody body) async {
    try {
      isLoading.value = true;
      var result = await AuthServices2.login(body);
      isLoading.value = false;
      if (!result.status) {
        showBasicAlertDialog(result.message);
      }
      return result;
    } catch (err) {
      showErrorDialog();
      isLoading.value = false;
      return null;
    }
  }

  Future<bool> emailUniqueCheck(email) async {
    try {
      isLoading.value = true;
      var result = await AuthServices2.emailUniqueCheck(email);
      isLoading.value = false;
      if (!result.status) {
        showBasicAlertDialog(result.message);
      }
      return result.status;
    } catch (err) {
      showErrorDialog();
      isLoading.value = false;
      return false;
    }
  }

  Future<IdFindResponse?> findId(name, contact) async {
    try {
      isLoading.value = true;
      var result = await AuthServices2.findId(name, contact);
      showBasicAlertDialog(result.message);
      isLoading.value = false;
      return result;
    } catch (err) {
      showErrorDialog();
      isLoading.value = false;
      return null;
    }
  }

  Future<void> resetPassword(email, password, appName, successText) async {
    try {
      isLoading.value = true;
      var result = await AuthServices2.resetPassword(email, password);
      if (result.status) {
        await Get.find<UserController2>().deleteInfo(appName, true);
        Get.offAll(() => Get.find<AppController2>().appInfo.value!.loginPage);
        showBasicAlertDialog(successText);
      } else {
        showBasicAlertDialog(result.message);
      }
      isLoading.value = false;
      return;
    } catch (err) {
      showErrorDialog();
      isLoading.value = false;
      return;
    }
  }
}
