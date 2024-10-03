import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class CustomRatingBar extends StatelessWidget {
  CustomRatingBar({
    Key? key,
    this.alignment,
    this.ignoreGestures,
    this.initialRating,
    this.itemSize,
    this.itemCount,
    this.color,
    this.unselectedColor,
    this.onRatingUpdate,
  }) : super(key: key);

  final Alignment? alignment;
  final bool? ignoreGestures;
  final double? initialRating;
  final double? itemSize;
  final int? itemCount;
  final Color? color;
  final Color? unselectedColor;
  Function(double)? onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: ratingBarWidget,
    )
        : ratingBarWidget;
  }

  Widget get ratingBarWidget => RatingBar.builder(
    ignoreGestures: ignoreGestures ?? false,
    initialRating: initialRating ?? 0.0, // Show 0 stars if initialRating is null.
    minRating: 0.1, // Minimum rating to prevent zero-rating.
    direction: Axis.horizontal,
    allowHalfRating: false,
    itemSize: itemSize ?? 26,
    unratedColor: unselectedColor ?? Colors.grey,
    itemCount: itemCount ?? 5,
    updateOnDrag: true,
    itemBuilder: (context, _) {
      return Icon(
        Icons.star,
        color: color ?? Colors.yellow,
      );
    },
    onRatingUpdate: (rating) {
      if (rating >= 0.1) {
        onRatingUpdate?.call(rating);
      }
    },
  );
}
