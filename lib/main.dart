import 'dart:convert';
import 'dart:io';
import 'package:aleena/src/features/AuthFeature/ui/screens/login_screen.dart';
import 'package:aleena/src/features/AuthFeature/ui/screens/waiting_confirm_screen.dart';
import 'package:aleena/src/features/HomeFeature/ui/screens/home_screen.dart';
import 'package:aleena/src/features/NotificatoinsFeature/Bloc/model/notification_model.dart';
import 'package:aleena/src/features/NotificatoinsFeature/Ui/Screen/notifications_screen.dart';
import 'package:aleena/src/features/SplachFeature/ui/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'src/core/services/Lang/localization_services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'src/core/services/notification_badge.dart';
import 'src/features/HomeFeature/bloc/controller/home_controller.dart';
import 'src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:aleena/src/bloc/models/flutter_model.dart';
import 'package:aleena/src/core/services/notification_badge.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'src/ui/widgets/custom_snack_bar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


GetStorage box = GetStorage();


// start background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);
  if(message.data['type']!=null){
    if(message.data['type']=='active'){
      box.write('active',1);
      box.write('login',1);
      box.write('WaitingConfirmationScreen',0);
      HomeController _homeController = Get.put(HomeController());
      _homeController.fetchRegoins();
      Get.offAll(()=> HomeScreen());
    }else if(message.data['type']=='disactive'){
      box.write('active',0);
      box.write('login',0);
      box.write('WaitingConfirmationScreen',1);
      Get.offAll(()=> WaitingConfirmationScreen());
    }
  }
  flutterLocalNotificationsPlugin.show(
      0,
      message.data['title'],
      message.data['msg'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          enableVibration: true,
        ),
      ),
      payload: json.encode(message.data.toString())
  );
}
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.high,

);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
// end background

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  // start background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  // end background
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  GetStorage box = GetStorage();
  late final FirebaseMessaging _messaging;
  HomeController _homeController = Get.put(HomeController());
  // register notification
  // void registerNotification()async{
  //   await Firebase.initializeApp();
  //   // instance for firebase messaging
  //   _messaging = FirebaseMessaging.instance;
  //   _messaging.subscribeToTopic("all");
  //   _messaging.subscribeToTopic("shop");
  //   //three type of state in notification
  //   NotificationSettings seetings = await _messaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     provisional: false,
  //     sound:true,
  //   );
  //
  //   if(seetings.authorizationStatus==AuthorizationStatus.authorized )
  //   {
  //     print("User granted the permission");
  //     // main message
  //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //       print("notification message step 1");
  //       print("notification message step 2");
  //       print("notification message.notification1 is >>> ${message.data}");
  //       print("notification message step 3");
  //       if(message!=null){
  //         customSnackBar(title: message.data['title']??"",subtitle:   message.data['msg'],);
  //         _homeController.fetchHome();
  //       }
  //     });
  //
  //     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //       print('A new onMessageOpenedApp event was published!');
  //       // Get.to(HomeScreen());
  //     });
  //
  //     // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  //
  //   }else{
  //     print("permition declined by user");
  //   }
  // }
  //
  // void messagesConfig()async{
  //   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //     alert: true, // Required to display a heads up notification
  //     badge: true,
  //     sound: true,
  //   );
  //   const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // titledescription
  //     importance: Importance.max,
  //   );
  // }
  void onSelectNotification(String? payload) async {
    //convert payload json to notification model object
    _homeController.fetchHome(refresh: true);
    print('a7aaaaaaaa ${payload}');
    var decodedData = jsonDecode(payload!);
    // print('a7oooooooo ${decodedData['ms']}');
    if(payload == 'active'){
      box.write('active',1);
      box.write('login',1);
      box.write('WaitingConfirmationScreen',0);
      Get.to(()=> HomeScreen());
      _homeController.fetchRegoins();
    }else{
      Get.to(()=> NotificatinsScreen());
    }
  }
  void registerNotification()async{
    await Firebase.initializeApp();
    // instance for firebase messaging
    _messaging = FirebaseMessaging.instance;
    _messaging.subscribeToTopic("all");
    _messaging.subscribeToTopic("shop");
    //three type of state in notification
    var initialzationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: onSelectNotification,);
    NotificationSettings seetings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound:true,
    );
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    if(seetings.authorizationStatus==AuthorizationStatus.authorized )
    {
      print("User granted the permission");
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("notification message.notification1 is >>> ${message.data['type']}");
        if(message.data['type']=='active'){
          box.write('active',1);
          box.write('login',1);
          box.write('WaitingConfirmationScreen',0);
          Get.offAll(()=> HomeScreen());
        }else if(message.data['type']=='disactive'){
          box.write('active',0);
          box.write('login',0);
          box.write('WaitingConfirmationScreen',1);
          Get.offAll(()=> WaitingConfirmationScreen());
        }
        flutterLocalNotificationsPlugin.show(
            0,
            message.data['title'],
            message.data['msg'],
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                enableVibration: true,
              ),
            ),
            payload: message.data['type']??''
        );
        _homeController.fetchHome(refresh: true);
      });
    }else{
      print("permition declined by user");
    }
  }

  @override
  void initState() {
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
          // home: LoginScreen(),
        ),
      ),
    );
  }
}
