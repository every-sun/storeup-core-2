import 'package:flutter/material.dart';
import 'package:user_core2/widget/custom_header_delegate.dart';
import 'package:get/get.dart';
import 'package:user_core2/widget/text/notosans_text.dart';

class CustomSliverPersistentHeader extends StatelessWidget {
  const CustomSliverPersistentHeader(
      {Key? key,
      required this.title,
      required this.icons,
      required this.fixedWidget,
      required this.height,
      required this.isFixed,
      required this.titleSize,
      required this.containerPadding,
      required this.prevIcon})
      : super(key: key);
  final String? title;
  final Widget icons;
  final Widget fixedWidget;
  final double height;
  final RxBool isFixed;
  final EdgeInsets containerPadding;
  final double titleSize;
  final Widget prevIcon;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: CustomHeaderDelegate(
          height: height,
          widget: Column(
            children: [
              Obx(() => Visibility(
                    visible: isFixed.value,
                    child: Container(
                        width: double.infinity,
                        padding: containerPadding,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (title != null)
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 180,
                                  child: Center(
                                    child: NotoText(
                                      content: title!,
                                      size: titleSize,
                                      weight: 'M',
                                    ),
                                  )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [prevIcon, icons],
                            )
                          ],
                        )),
                  )),
              fixedWidget
            ],
          )),
      pinned: true,
      // floating : false
    );
  }
}
