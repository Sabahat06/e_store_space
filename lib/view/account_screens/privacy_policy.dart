import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
          leadingWidth: 30,
          title: const Text('Privacy Policy', style: TextStyle(color: Colors.white),),
        ),
        body: Center(
          child: Container(
            child: Text('Data For Privacy Policy', style: TextStyle(fontSize: 16.sp, color: Colors.black),),
          ),
        )
    );
  }
}
