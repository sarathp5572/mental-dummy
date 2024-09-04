import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:mentalhelth/screens/renew_upgrade_plan_screen/widgets/renewupgradeplan_item_widget.dart';
import 'package:mentalhelth/widgets/app_bar/appbar_leading_image.dart';

import '../../utils/theme/custom_text_style.dart';
import '../../utils/theme/theme_helper.dart';

// ignore: must_be_immutable
class RenewUpgradePlanScreen extends StatelessWidget {
  RenewUpgradePlanScreen({Key? key})
      : super(
          key: key,
        );

  List renewupgradeplanItemList = [
    {'id': 1, 'groupBy': "My current plan"},
    {'id': 2, 'groupBy': "Choose Other plans"},
    {'id': 3, 'groupBy': "Choose Other plans"}
  ];

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(
          context,
          size,
          heading: 'Renew plan',
        ),
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 26,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRenewUpgradePlan(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRenewUpgradePlan(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: GroupedListView<dynamic, String>(
        shrinkWrap: true,
        stickyHeaderBackgroundColor: Colors.transparent,
        elements: renewupgradeplanItemList,
        groupBy: (element) => element['groupBy'],
        sort: false,
        groupSeparatorBuilder: (String value) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 40,
              bottom: 9,
            ),
            child: Text(
              value,
              style: CustomTextStyles.bodyLargeRoboto.copyWith(
                color: theme.colorScheme.primary.withOpacity(1),
              ),
            ),
          );
        },
        itemBuilder: (context, model) {
          return const RenewUpgradePlanItemWidget();
        },
      ),
    );
  }
}
