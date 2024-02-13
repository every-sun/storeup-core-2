class CharacterMethod {
  static bool isKorean(String char) {
    final regex = RegExp(r'^[ㄱ-ㅎ가-힣]+$');
    return regex.hasMatch(char);
  }

  static bool isNumeric(String char) {
    final regExp = RegExp(r'^[0-9]+$');
    return regExp.hasMatch(char);
  }

  static bool isEnglish(String char) {
    final regex = RegExp(r'^[a-zA-Z]+$');
    return regex.hasMatch(char);
  }

  static String getFont(String char) {
    if (isNumeric(char) || isEnglish(char) || char == ',') {
      return 'Roboto';
    } else {
      return 'NotoSansKR';
    }
  }
}
