import 'package:flutter/material.dart';
import 'package:mentalhelth/utils/core/image_constant.dart';
import 'package:mentalhelth/utils/theme/theme_helper.dart';
import 'package:mentalhelth/widgets/custom_image_view.dart';

// ignore: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({super.key, this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHome,
      activeIcon: ImageConstant.imgHome,
      type: BottomBarEnum.home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgSettings,
      activeIcon: ImageConstant.imgSettings,
      type: BottomBarEnum.settings,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgMegaphone,
      activeIcon: ImageConstant.imgMegaphone,
      type: BottomBarEnum.megaphone,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgArrowDown,
      activeIcon: ImageConstant.imgArrowDown,
      type: BottomBarEnum.arrowDown,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(1),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      child: BottomNavigationBar(
        // backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: bottomMenuList[index].icon,
              height: 24,
              width: 24,
              color: theme.colorScheme.primary.withOpacity(1),
            ),
            activeIcon: CustomImageView(
              imagePath: bottomMenuList[index].activeIcon,
              height: 24,
              width: 24,
              color: theme.colorScheme.primary.withOpacity(1),
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

enum BottomBarEnum {
  home,
  settings,
  megaphone,
  arrowDown,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
  });

  String icon;

  String activeIcon;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
