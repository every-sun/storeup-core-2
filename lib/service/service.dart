import 'package:get/get.dart';
import 'package:user_core2/controller/user_controller.dart';

class ServiceAPI {
  UserController2 controller = Get.put(UserController2());
  final String baseUrl = 'https://cms2.amuz/api';

  final headerInfo = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
  final userHeaderInfo = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer ${Get.find<UserController2>().token}",
  };
}
