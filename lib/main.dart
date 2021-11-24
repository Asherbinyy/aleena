import 'package:aleena/src/features/AuthFeature/ui/screens/location_welcome_screen.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/login_screen.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/phone_input_screen.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/register_screen.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/waiting_confirm_screen.dart';
import 'package:aleena/src/features/DrawerFeature/ui/screens/GeneralSettingScreens/change_password_screen.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/home_screen.dart';
import 'package:aleena/src/features/SplachFeature/ui/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'src/core/services/Lang/localization_services.dart';
import 'src/features/AuthFeature/ui/screens/register_info_screen.dart';
import 'src/features/DrawerFeature/ui/screens/LastOrdersScreen/last_orders_screen.dart';
import 'src/features/DrawerFeature/ui/screens/GeneralSettingScreens/personal_settings.dart';
import 'src/features/HomeFeature/ui/screens/add_order.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () =>  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 200),
        translations: LocalizationServices(),
        locale: LocalizationServices().getCurrentLocale(),
        fallbackLocale: const Locale("ar", "AE"),
        title: '3leena App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
