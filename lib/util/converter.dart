import 'package:intl/intl.dart';

class Converter {
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: "ko_KR", name: "", decimalDigits: 0);

  String numberToPrice(int price) {
    return formatCurrency.format(price);
  }

  String formatPhoneNumber(String contactNumber) {
    contactNumber = contactNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (contactNumber.length == 10) {
      contactNumber = contactNumber.replaceFirstMapped(
        RegExp(r'(\d{3})(\d{3})(\d{4})'),
        (match) => '${match[1]}-${match[2]}-${match[3]}',
      );
    } else if (contactNumber.length == 11) {
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

  String getCloseTimeString(value) {
    //18:15
    var hour = value.split(':')[0];
    var minute = value.split(':')[1];
    if (int.parse(hour) > 24) {
      var stringHour = (int.parse(hour) - 24).toString();
      return '${stringHour.length < 10 ? '0$stringHour' : stringHour}:$minute" (다음날)"';
    } else {
      return value;
    }
  }

  final Map weekData = {
    'mon': '월요일',
    'tue': '화요일',
    'wed': '수요일',
    'thu': '목요일',
    'fri': '금요일',
    'sat': '토요일',
    'sun': '일요일'
  };

  final List<Map> holidayData = [
    {
      'value': 1,
      'label': '첫째',
    },
    {
      'value': 2,
      'label': '둘째',
    },
    {
      'value': 3,
      'label': '셋째',
    },
    {'value': 4, 'label': '넷째'},
    {'value': 5, 'label': '다섯째'},
    {'value': 6, 'label': '마지막 주'}
  ];

  String getOpeningHours(map) {
    String result = '';
    map.forEach((key, value) {
      if (value['is_all_day']) {
        result += '${weekData[key]}: 24시간\n';
      } else {
        result +=
            '${weekData[key]}: ${value['from']}~${getCloseTimeString(value['to'])}\n';
      }
    });
    return result.trim();
  }

  String getWeekStringFromNumberArr(numberArr) {
    numberArr.sort();
    if (numberArr.length >= 6) {
      return '매주 ';
    }
    var result = '매월 ';
    for (var i = 0; i < numberArr.length; i++) {
      result +=
          '${holidayData.firstWhere((e) => e['value'] == numberArr[i])['label']}주';
      if (i != numberArr.length - 1) {
        result += ', ';
      }
    }
    result += ' ';

    return result;
  }

  String getRegularHolidayValue(value, isPublicHoliday) {
    String result = '';
    value.entries.forEach((v) => {
          if (v.value.isNotEmpty)
            {
              result +=
                  '${getWeekStringFromNumberArr(v.value) + weekData[v.key]}\n'
            }
        });
    if (isPublicHoliday) {
      result += '공휴일 휴무';
    }
    return result.trim();
  }
}
