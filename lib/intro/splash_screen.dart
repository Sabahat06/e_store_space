import 'package:cached_map/cached_map.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/view/homepage.dart';


class SplashScreen extends StatelessWidget {
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    navigate();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 180,
          height: 180,
          child: Image.asset("assets/image/yusuflogo.png",)
        ),
      ),
    );
  }


  navigate() async {
    await Future.delayed(Duration(seconds: 3));
    Mapped.loadFileDirectly(cachedFileName: "slider").then((file) {
      Get.off(()=> HomePage());
    });
  }
}
