import 'package:flutter/material.dart';
import 'package:medicine_app/core/app_export.dart';
import 'package:medicine_app/presentation/main_chat_screen/chat_tab_container_page.dart';
import 'package:medicine_app/widgets/custom_bottom_bar.dart';

class ThirtyfiveContainerScreen extends StatelessWidget {
  ThirtyfiveContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        body: Navigator(
            key: navigatorKey,
            initialRoute: AppRoutes.thirtyfiveTabContainerPage,
            onGenerateRoute: (routeSetting) => PageRouteBuilder(
                pageBuilder: (ctx, ani, ani1) =>
                    getCurrentPage(routeSetting.name!),
                transitionDuration: Duration(seconds: 0))),
        bottomNavigationBar: _buildBottomBar(context));
  }

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {});
  }

  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.thirtyfiveTabContainerPage:
        return ThirtyfiveTabContainerPage();
      default:
        return ThirtyfiveTabContainerPage();
    }
  }
}