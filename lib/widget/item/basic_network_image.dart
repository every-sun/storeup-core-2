import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:user_core2/widget/text/notosans_text.dart';

class BasicNetworkImage extends StatelessWidget {
  const BasicNetworkImage(
      {Key? key,
      required this.width,
      this.height,
      required this.url,
      this.color})
      : super(key: key);
  final String? url;
  final double width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return url != null
        ? CachedNetworkImage(
            imageUrl: url!,
            width: width,
            height: height,
            fit: BoxFit.cover,
            color: color,
            fadeOutDuration: const Duration(milliseconds: 200),
            fadeInDuration: const Duration(milliseconds: 100),
            placeholder: (context, url) => Container(
              color: const Color.fromRGBO(204, 204, 204, 0.3),
              child: const Center(
                child: NotoText(
                  content: '로딩중',
                  size: 10,
                  color: 0xffcccccc,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: const Color.fromRGBO(204, 204, 204, 0.3),
              child: const Center(
                  child:
                      Icon(Icons.error, color: Color.fromRGBO(0, 0, 0, 0.6))),
            ),
          )
        : Image.asset(
            'assets/images/no-image.png',
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
  }
}
