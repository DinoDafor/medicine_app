import 'package:flutter/material.dart';
import 'package:medicine_app/core/app_export.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgNav,
      activeIcon: ImageConstant.imgNav,
      title: "Главная",
      type: BottomBarEnum.tf,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavGray500,
      activeIcon: ImageConstant.imgNavGray500,
      title: "Календарь..",
      type: BottomBarEnum.tf,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavTealA700,
      activeIcon: ImageConstant.imgNavTealA700,
      title: "Чаты",
      type: BottomBarEnum.tf,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavGray50024x24,
      activeIcon: ImageConstant.imgNavGray50024x24,
      title: "Статьи",
      type: BottomBarEnum.tf,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNav24x24,
      activeIcon: ImageConstant.imgNav24x24,
      title: "Профиль",
      type: BottomBarEnum.tf,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.v,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.h),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[index].icon,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  color: appTheme.gray500,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.v),
                  child: Text(
                    bottomMenuList[index].title ?? "",
                    style: theme.textTheme.labelMedium!.copyWith(
                      color: appTheme.gray500,
                    ),
                  ),
                ),
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[index].activeIcon,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  color: appTheme.tealA700,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.v),
                  child: Text(
                    bottomMenuList[index].title ?? "",
                    style: CustomTextStyles.labelMediumTealA700.copyWith(
                      color: appTheme.tealA700,
                    ),
                  ),
                ),
              ],
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
  tf,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
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