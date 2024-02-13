import 'dart:math';

class ArrayMethod {
  static List<dynamic> shuffle(List<dynamic> array) {
    var random = Random();
    for (var i = array.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = array[i];
      array[i] = array[n];
      array[n] = temp;
    }
    return array;
  }
}
