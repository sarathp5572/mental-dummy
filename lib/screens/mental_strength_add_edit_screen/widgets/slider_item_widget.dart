import 'package:flutter/material.dart';

import '../../../utils/theme/custom_text_style.dart';

// ignore: must_be_immutable
class Slider1ItemWidget extends StatelessWidget {
  const Slider1ItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(57, 11, 60, 14),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Text(
        "I just feel excited now, hope it will \nbe an amazing day.",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: CustomTextStyles.bodyMediumGray700,
      ),
    );
  }
}
