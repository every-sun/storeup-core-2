class CharacterMethod {
  static bool _isNumeric(String char) {
    final regExp = RegExp(r'^[0-9]+$');
    return regExp.hasMatch(char);
  }

  static bool _isEnglish(String char) {
    final regex = RegExp(r'^[a-zA-Z]+$');
    return regex.hasMatch(char);
  }

  static String getFont(String char) {
    if (_isNumeric(char) || _isEnglish(char) || char == ',') {
      return 'Roboto';
    } else {
      return 'NotoSansKR';
    }
  }
}
