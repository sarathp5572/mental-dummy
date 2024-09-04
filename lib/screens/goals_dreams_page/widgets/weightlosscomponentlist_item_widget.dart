import 'package:flutter/material.dart';
import 'package:mentalhelth/utils/core/date_time_utils.dart';
import 'package:mentalhelth/utils/theme/theme_helper.dart';

import '../../../utils/theme/app_decoration.dart';
import '../../../utils/theme/custom_text_style.dart';

// ignore: must_be_immutable
class WeightLossComponentListItemWidget extends StatelessWidget {
  const WeightLossComponentListItemWidget({
    Key? key,
    required this.image,
    required this.headding,
    required this.status,
    required this.startDate,
    required this.endDate,
  }) : super(
          key: key,
        );
  final String image;
  final String headding;
  final bool status;
  final String startDate;
  final String endDate;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 13,
      ),
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      decoration: status
          ? AppDecoration.outlineGray100WithOpacity08.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            )
          : BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image == null
              ? const SizedBox()
              : CircleAvatar(
                  backgroundColor: appTheme.gray50,
                  radius: size.height * 0.035,
                  backgroundImage: NetworkImage(image),
                ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              bottom: 13,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.5,
                  child: Text(
                    headding,
                    style: CustomTextStyles.titleMedium16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                status
                    ? Text(
                        "Completed",
                        style: CustomTextStyles.bodySmallGray700_1,
                      )
                    : Row(
                        children: [
                          Text(
                            formatDate(
                              int.parse(startDate),
                            ),
                            style: theme.textTheme.bodySmall,
                          ),
                          Text(
                            "  to  ",
                            style: theme.textTheme.bodySmall,
                          ),
                          Text(
                            endDate == ""
                                ? ""
                                : formatDate2(int.parse(endDate)),
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
