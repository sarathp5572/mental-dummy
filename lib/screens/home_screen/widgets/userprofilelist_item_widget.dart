import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mentalhelth/utils/core/date_time_utils.dart';
import 'package:mentalhelth/utils/theme/app_decoration.dart';
import 'package:html_unescape/html_unescape.dart';
import '../../../utils/theme/theme_helper.dart';

// ignore: must_be_immutable
class UserProfileListItemWidget extends StatelessWidget {
  const UserProfileListItemWidget(
      {Key? key, required this.title, required this.date, required this.image})
      : super(
          key: key,
        );
  final String title;
  final String date;
  final String image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var logger = Logger();
    logger.w("title ${title}");
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 6,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image!=null?
          CircleAvatar(
            radius: size.width * 0.05,
            backgroundColor: Colors.grey[100],
            backgroundImage: NetworkImage(image),
          ):
              const SizedBox(),
          Padding(
            padding: const EdgeInsets.only(
              left: 17,
              top: 2,
              bottom: 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 270,
                  // color: Colors.red,
                  child: Text(
                    HtmlUnescape().convert(title.toString()), // Decoding HTML entities
                    style: theme.textTheme.bodyMedium,
                  ),
                ),

                Text(
                  formatMilliseconds(int.parse(date)),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
