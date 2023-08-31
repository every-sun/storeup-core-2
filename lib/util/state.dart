import 'package:user_core2/controller/user_controller.dart';
import 'package:get/get.dart';

class State1 {
  static int customerId = Get.find<UserController2>().customer.value!.id;
}
