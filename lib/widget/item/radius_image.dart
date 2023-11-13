import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:user_core2/widget/basic_skeleton.dart';

class RadiusImage extends StatelessWidget {
  const RadiusImage({
    Key? key,
    required this.imageUrl,
    required this.borderRadius,
    required this.size,
  }) : super(key: key);
  final String? imageUrl;
  final double borderRadius;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: imageUrl != null
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                width: size,
                height: size,
                fit: BoxFit.cover,
                fadeOutDuration: const Duration(milliseconds: 200),
                fadeInDuration: const Duration(milliseconds: 100),
                placeholder: (context, url) =>
                    BasicSkeleton(width: size, height: size, radius: 0),
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
