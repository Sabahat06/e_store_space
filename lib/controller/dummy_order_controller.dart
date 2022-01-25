// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:e_store_space/view/home_screen_tabs/account_screen_tab.dart';
// class DummyOrderController extends GetxController{
//
// BuildContext context;
//
// DummyOrderController(this.context);
//
//   AndroidNotificationChannel channel = const AndroidNotificationChannel(
//       'high_importance_channel', // id
//       'High Importance Notifications', // title
//       // description
//       importance: Importance.high,
//       playSound: true);
//
//    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//    // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//    //   await Firebase.initializeApp();
//    //   print('A bg message just showed up :  ${message.messageId}');
//    // }
//
//
//    @override
//   void onInit() async {
//
//      // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//      //
//      // await flutterLocalNotificationsPlugin
//      //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//      //     ?.createNotificationChannel(channel);
//      //
//      // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//      //   alert: true,
//      //   badge: true,
//      //   sound: true,
//      // );
//
//
//      //
//      // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//      //   print('A new onMessageOpenedApp event was published!');
//      //   RemoteNotification notification = message.notification;
//      //   AndroidNotification android = message.notification?.android;
//      //   if (notification != null && android != null) {
//      //     showDialog(
//      //         barrierDismissible: false,
//      //         context: context,
//      //         builder: (context) {
//      //           return AlertDialog(
//      //             title: Text('Alert'),
//      //             content: Text('You have to update Application'),
//      //             actions: <Widget>[
//      //               // TextButton(
//      //               //     onPressed: () {
//      //               //       // _dismissDialog();
//      //               //     },
//      //               //     child: Text('Close')),
//      //               TextButton(
//      //                 onPressed: () {
//      //                   print('HelloWorld!');
//      //                   // _dismissDialog();
//      //                 },
//      //                 child: Text('Update Now!'),
//      //               )
//      //             ],
//      //           );
//      //         });
//      //   }
//      // });
//
//     super.onInit();
//   }
//
//
//   // void sendNotification(RemoteMessage message ){
//   //   flutterLocalNotificationsPlugin.show(
//   //       0,
//   //       "Yousuf Mobile",
//   //       "your order is on the way",
//   //       NotificationDetails(
//   //           android: AndroidNotificationDetails(
//   //               channel.id, channel.name,
//   //               importance: Importance.high,
//   //               color: Colors.blue,
//   //               playSound: true,
//   //               icon: '@mipmap/ic_launcher')));
//   // }
//
//
// }