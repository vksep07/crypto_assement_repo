import 'package:crypto_assignment/common/routes/routes.dart';
import 'package:crypto_assignment/common/services/navigation_service.dart';
import 'package:crypto_assignment/util/string_constant.dart';
import 'package:crypto_assignment/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: false,
      navigatorKey: appNavigationService.myNavigatorKey,
      theme: AppTheme.lightTheme,
      title: stringConstant.appName,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.getGeneratedRoute,
      initialRoute: Routes.splash,
    );
  }
}
