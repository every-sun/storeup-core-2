import 'package:user_core2/model/cart.dart';
import 'package:user_core2/util/converter.dart';

String getOptionString(List<CartOption> options) {
  String result = '';
  for (var i = 0; i < options.length; i++) {
    if (options[i].childrenOptions.isEmpty) {
      continue;
    } else {
      for (var j = 0; j < options[i].childrenOptions.length; j++) {
        result +=
            '${options[i].childrenOptions[j]['name']}${options[i].childrenOptions[j]['price'] > 0 ? '(+${Converter().numberToPrice(options[i].childrenOptions[j]['price'])}원), ' : ', '}';
      }
      result += '\n';
    }
  }
  return result.substring(0, result.length - 3);
}
