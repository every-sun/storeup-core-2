import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BasicSkeleton extends StatelessWidget {
  const BasicSkeleton(
      {Key? key,
      required this.width,
      required this.height,
      required this.radius})
      : super(key: key);
  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color.fromRGBO(240, 240, 240, 1),
        highlightColor: const Color(0xffffffff),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: const Color(0xffcccccc)),
        ));
  }
}
