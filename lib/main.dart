import 'dart:io';
import 'package:aleena/src/features/HomeFeature/ui/screens/home_screen.dart';
import 'package:aleena/src/features/NotificatoinsFeature/Bloc/model/notification_model.dart';
import 'package:aleena/src/features/SplachFeature/ui/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'src/core/services/Lang/localization_services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'src/core/services/notification_badge.dart';
import 'src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/bloc/models/flutter_model.dart';
import 'package:aleena/src/core/services/notification_badge.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'src/ui/widgets/custom_snack_bar.dart';



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  late final FirebaseMessaging _messaging;

  // register notification
  void registerNotification()async{
    await Firebase.initializeApp();
    // instance for firebase messaging
    _messaging = FirebaseMessaging.instance;
    _messaging.subscribeToTopic("all");
    _messaging.subscribeToTopic("shop");
    //three type of state in notification
    NotificationSettings seetings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound:true,
    );

    if(seetings.authorizationStatus==AuthorizationStatus.authorized )
    {
      print("User granted the permission");
      // main message
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("notification message step 1");
        print("notification message step 2");
        print("notification message.notification1 is >>> ${message.data}");
        print("notification message step 3");

        if(message!=null){
          customSnackBar(title: message.data['title']??"",subtitle:   message.data['msg'],);
        }

      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        Get.to(HomeScreen());
      });


    }else{
      print("permition declined by user");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    registerNotification();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () =>  OverlaySupport(
        child: GetMaterialApp(
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
      ),
    );
  }
}
