import 'package:intl/intl.dart';

class Converter {
  final formatCurrency = NumberFormat.simpleCurrency(locale: "ko_KR", name: "", decimalDigits: 0);

  String numberToPrice(int price){
    return formatCurrency.format(price);
  }

  String formatPhoneNumber(String contactNumber) {
    contactNumber = contactNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (contactNumber.length == 10) {
      contactNumber = contactNumber.replaceFirstMapped(
        RegExp(r'(\d{3})(\d{3})(\d{4})'),
            (match) => '${match[1]}-${match[2]}-${match[3]}',
      );
    } else if (contactNumber
        .length == 11) {
      contactNumber = contactNumber.replaceFirstMapped(
        RegExp(r'(\d{3})(\d{4})(\d{4})'),
            (match) => '${match[1]}-${match[2]}-${match[3]}',
      );
    } else if (contactNumber.length > 11) {
      contactNumber = contactNumber.substring(0, 11);
      contactNumber = contactNumber.replaceFirstMapped(
        RegExp(r'(\d{3})(\d{4})(\d{4})'),
            (match) => '${match[1]}-${match[2]}-${match[3]}',
      );
    } else if (contactNumber.length > 6) {
      contactNumber = contactNumber.replaceFirstMapped(
        RegExp(r'(\d{3})(\d{0,4})(\d{0,4})'),
            (match) => '${match[1]}-${match[2]}-${match[3]}',
      );
    } else if (contactNumber.length > 3) {
      contactNumber = contactNumber.replaceFirstMapped(
        RegExp(r'(\d{3})(\d{0,3})'),
            (match) => '${match[1]}-${match[2]}',
      );
    } else if (contactNumber.isNotEmpty) {
      contactNumber = contactNumber.replaceFirstMapped(
        RegExp(r'(\d{0,3})'),
            (match) => '${match[1]}',
      );
    }
    return contactNumber;
  }
}
