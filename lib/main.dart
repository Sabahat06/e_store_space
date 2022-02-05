import 'dart:io';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/product_category_controller.dart';
import 'package:e_store_space/controller/wish_list_controller.dart';
import 'package:e_store_space/intro/splash_screen.dart';
import 'package:e_store_space/services/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'controller/bottom_bar_controller.dart';

Future<void> backgroundHandler(RemoteMessage message) async {

  // currentOrder = await HttpService.getOrderWithID(message.data['order_id']);
  // print(message.data.toString());
  // print(message.notification.title);
}

// Orders currentOrder;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    LocalNotificationService.initialize(context);
    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      // final authController = await Get.put(AuthController());
      // if(message != null){
      //   final routeFromMessage = message.data["route"];
      //   currentOrder = await HttpService.getOrderWithID(message.data['order_id']);
      //   Get.toNamed(routeFromMessage);
      //   Navigator.of(context).pushNamed(routeFromMessage);
      // }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) async {
      // if(message.notification != null){
      //   final routeFromMessage = message.data["route"];
      //   currentOrder = await HttpService.getOrderWithID(message.data['order_id']);
      //   Get.toNamed(routeFromMessage);
      //   print(message.notification.body);
      //   print(message.notification.title);
      // }
      LocalNotificationService.display(message);
    });
    // HttpService.getAppSettings();
    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      // final routeFromMessage = message.data["route"];
      // currentOrder = await HttpService.getOrderWithID(message.data['order_id']);
      //
      // if(message.data != null){
      //   Get.toNamed(routeFromMessage);
      // }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductCategoryController productCategoryController = Get.put(ProductCategoryController());
    final authController = Get.put(AuthController());
    final wishListController = Get.put(WishListController());
    final bottomController = Get.put(BottomBarController());
    return Sizer(
      builder: (context,orientation,deviceType){
        // cartControllerNew.cart.items.clear();
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          splitScreenMode: true,
          builder: () => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              fontFamily: 'Nunito',
              primarySwatch: Colors.blue,
            ),
            home: SplashScreen() ,
            // routes: {
            //   'orders_history' : (_)=>OrderHistoryScreen(),
            //   'order_status' : (_)=> currentOrder==null?OrderHistoryScreen(): OrderStatusScreen( order: currentOrder,),
            //   'usedDevices' : (_)=> UsedMobileScreenTab(),
            // },
          ),
        );
      },
    );
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

// currentOrder = await HttpService.getOrderWithID(message.data['order_id']);





