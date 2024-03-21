import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/service/auth_service.dart';
import 'package:user_core2/model/auth.dart';
import 'package:user_core2/util/dialog.dart';

class AuthController extends GetxController {
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
          brandId: Get.find<AppController>().appInfo.value!.brandId,
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
          Get.find<AppController>().appInfo.value!.brandId;
      var result = await AuthServices.register(registerRequestBody.value!);
      isLoading.value = false;
      if (!result.status) {
        showBasicAlertDialog(result.message);
      }
      return result.status;
    } catch (err) {
      showBasicAlertDialog('회원가입에 실패하였습니다.');
      isLoading.value = false;
      return false;
    }
  }

  Future<LoginResponse?> login(LoginRequestBody body) async {
    try {
      isLoading.value = true;
      var result = await AuthServices.login(body);
      isLoading.value = false;
      if (!result.status) {
        showBasicAlertDialog(result.message);
      }
      return result;
    } catch (err) {
      showBasicAlertDialog('로그인에 실패하였습니다.');
      isLoading.value = false;
      return null;
    }
  }

  Future<bool> emailUniqueCheck(email) async {
    try {
      isLoading.value = true;
      var result = await AuthServices.emailUniqueCheck(email);
      isLoading.value = false;
      if (!result.status) {
        showBasicAlertDialog(result.message);
      }
      return result.status;
    } catch (err) {
      showBasicAlertDialog('아이디 중복체크에 실패하였습니다.');
      isLoading.value = false;
      return false;
    }
  }

  Future<IdFindResponse?> findId(name, contact) async {
    try {
      isLoading.value = true;
      var result = await AuthServices.findId(
          name, contact, Get.find<AppController>().appInfo.value!.brandId);
      isLoading.value = false;
      if (!result.status) {
        showBasicAlertDialog(result.message);
      }
      return result;
    } catch (err) {
      showBasicAlertDialog('아이디 찾기에 실패하였습니다.');
      isLoading.value = false;
      return null;
    }
  }

  Future<void> resetPassword(
      email, password, String customerKey, successText) async {
    try {
      isLoading.value = true;
      var result = await AuthServices.resetPassword(email, password);
      isLoading.value = false;
      if (result.status) {
        await Get.find<UserController>().deleteCustomer(customerKey);
        Get.offAll(() => Get.find<AppController>().appInfo.value!.loginPage);
        showBasicAlertDialog(successText);
      } else {
        showBasicAlertDialog(result.message);
      }
      return;
    } catch (err) {
      showBasicAlertDialog('비밀번호 재설정에 실패하였습니다.');
      isLoading.value = false;
      return;
    }
  }

  Future<void> checkPassword(password, successMethod) async {
    try {
      isLoading.value = true;
      var result = await AuthServices.checkPassword(
          Get.find<UserController>().customer.value!.email, password);
      isLoading.value = false;
      if (result.status) {
        successMethod();
      } else {
        showBasicAlertDialog(result.message);
      }
      return;
    } catch (err) {
      showBasicAlertDialog('비밀번호 검증에 실패하였습니다.');
      isLoading.value = false;
      return;
    }
  }
}
