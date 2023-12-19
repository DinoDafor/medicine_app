import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:medicine_app/theme/theme_helper.dart';
import 'package:medicine_app/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'medicine_app',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.loginAsScreen,
      routes: AppRoutes.routes,
    );
  }
}
