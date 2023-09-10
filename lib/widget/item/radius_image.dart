import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:user_core2/widget/text/notosans_text.dart';

class RadiusImage extends StatelessWidget {
  const RadiusImage(
      {Key? key,
      required this.imageUrl,
      required this.borderRadius,
      required this.size,
      this.height})
      : super(key: key);
  final String? imageUrl;
  final double borderRadius;
  final double size;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: imageUrl != null
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                width: size,
                height: height ?? size,
                fit: BoxFit.cover,
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
                    child: Icon(Icons.error),
                  ),
                ),
              )
            : Image.asset('assets/images/no-image.png',
                width: size, height: size, fit: BoxFit.cover));
  }
}
