import 'package:cached_map/cached_map.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          width: 250.w,
          height: 250.h,
          child: Image.asset("assets/image/logo.png",)
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
