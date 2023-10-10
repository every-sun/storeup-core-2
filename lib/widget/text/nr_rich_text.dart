import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:user_core2/util/character.dart';

class NRRichText extends StatefulWidget {
  const NRRichText(
      {Key? key,
      required this.text,
      required this.commonStyle,
      this.isCenter = false,
      this.maxLines = 1})
      : super(key: key);
  final String text;
  final TextStyle commonStyle;
  final int maxLines;
  final bool isCenter;

  @override
  State<NRRichText> createState() => _NRRichTextState();
}

class _NRRichTextState extends State<NRRichText> {
  bool _isLoading = false;
  List<TextSpan> textSpanList = [];

  @override
  void initState() {
    getName();
    super.initState();
  }

  Future<String> getName() async {
    String tempText = '';
    String tempFont = '';

    void add() {
      if (tempText.isEmpty) return;
      textSpanList.add(TextSpan(
        text: tempText,
        style: TextStyle(fontFamily: tempFont),
      ));
    }

    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    String extractedText = widget.text;
    if (Get.deviceLocale?.languageCode != 'ko') {
      extractedText =
          await GoogleTranslatorController().translateText(widget.text);
    }
    for (var i = 0; i < extractedText.length + 1; i++) {
      if (i < extractedText.length) {
        if (CharacterMethod().getFont(extractedText[i]) == 'NotoSansKR') {
          if (tempFont != 'NotoSansKR') {
            add();
            tempText = '';
            tempFont = 'NotoSansKR';
          }
        } else if (CharacterMethod().getFont(extractedText[i]) == 'Roboto') {
          if (tempFont != 'Roboto') {
            add();
            tempText = '';
            tempFont = 'Roboto';
          }
        }
        tempText += extractedText[i];
      } else {
        add();
      }
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
    return extractedText;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container()
        : RichText(
            textAlign: widget.isCenter ? TextAlign.center : TextAlign.left,
            text: TextSpan(
              children: textSpanList,
              style: widget.commonStyle,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: widget.maxLines,
          );
  }
}
