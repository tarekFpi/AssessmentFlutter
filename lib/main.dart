import 'package:assessment/core/features/auth/login_screen.dart';
import 'package:assessment/core/features/theme/app_theme.dart';
import 'package:assessment/core/features/utils/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';

void main() async{

  await GetStorage.init();

  runApp(MyApp());

  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..backgroundColor = Colors.white
    ..indicatorColor = HexColor("#855EA9")
    ..textColor = Colors.black
    ..maskColor = Colors.white.withOpacity(0.8);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return OKToast(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        themeMode: ThemeMode.light,
        home:LoginScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

