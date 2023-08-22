import 'package:user_core2/model/cart.dart';
import 'package:user_core2/util/converter.dart';

String getOptionString(List<CartOption> options) {
  String result = '';
  for (var i = 0; i < options.length; i++) {
    for (var j = 0; j < options[i].childrenOptions.length; j++) {
      result +=
          '${options[i].childrenOptions[j]['name']}${options[i].childrenOptions[j]['price'] > 0 ? '(+${Converter().numberToPrice(options[i].childrenOptions[j]['price'])}원), ' : ', '}';
    }
    if (i < options.length - 1) {
      result += '\n';
    }
  }
  return result;
}
