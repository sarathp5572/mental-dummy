import 'package:flutter/material.dart';
import 'package:mentalhelth/utils/theme/theme_helper.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    this.alignment,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(33),
                  border: Border.all(
                    color: appTheme.blue300,
                    width: 1,
                  ),
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}

/// Extension on [CustomIconButton] to facilitate inclusion of all types of border style etc
extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray100,
        borderRadius: BorderRadius.circular(30),
      );
  static BoxDecoration get fillBlueA => BoxDecoration(
        color: appTheme.blueA40001,
        borderRadius: BorderRadius.circular(30),
      );
  static BoxDecoration get fillLightBlueA => BoxDecoration(
        color: appTheme.lightBlueA200,
        borderRadius: BorderRadius.circular(30),
      );
  static BoxDecoration get fillBlue => BoxDecoration(
        color: appTheme.blue300,
        borderRadius: BorderRadius.circular(35),
      );
}
