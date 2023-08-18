import 'package:flutter/material.dart';
import 'package:user_core2/util/converter.dart';

class PriceText extends StatelessWidget {
  const PriceText(
      {Key? key,
      required this.price,
      required this.weight,
      required this.size,
      this.height,
      this.color = 0xff000000})
      : super(key: key);
  final dynamic price;
  final FontWeight weight;
  final double size;
  final int color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
            text: Converter().formatCurrency.format(price),
            style: const TextStyle(
              fontFamily: 'Roboto',
            )),
        const TextSpan(
            text: '원',
            style: TextStyle(
              fontFamily: 'NotoSansKR',
            )),
      ]),
      style: TextStyle(
          height: height,
          fontWeight: weight,
          fontSize: size,
          color: Color(color),
          overflow: TextOverflow.ellipsis),
    );
  }
}
