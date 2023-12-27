import 'package:user_core2/model/order.dart';

bool isVirtualAccountValid(Order? order) {
  return order != null &&
      order.payments.isNotEmpty &&
      order.payments[0].virtualAccountData != null &&
      order.payments[0].virtualAccountData!['due_date'] != null &&
      DateTime.now().isBefore(
          DateTime.parse(order.payments[0].virtualAccountData!['due_date']));
}

bool isVirtualAccountUnValid(Order? order) {
  return order != null &&
      order.payments.isNotEmpty &&
      order.payments[0].virtualAccountData != null &&
      order.payments[0].virtualAccountData!['due_date'] != null &&
      !DateTime.now().isBefore(
          DateTime.parse(order.payments[0].virtualAccountData!['due_date']));
}
