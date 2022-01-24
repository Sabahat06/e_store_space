import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_store_space/settings/color_palates.dart';

class AlertDialogWidget extends StatelessWidget {
  String title;
  String subTitle;
  GestureTapCallback onPositiveClick;

  AlertDialogWidget({this.title, this.subTitle, this.onPositiveClick});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
      ),
    ),
      content: Text(subTitle, style: TextStyle(fontSize: 16, color: Colors.black),),
      actions: [
        // TextButton(
        //   child: Text(
        //       'No',
        //       style: TextStyle(
        //           fontSize: 16.sp,
        //           color: Colors.blue,
        //           fontWeight: FontWeight.bold)
        //   ),
        //   onPressed: (){Get.back();},
        // ),
        TextButton(
            child: Text(
              'OK',
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: onPositiveClick
        ),
      ],
    );
  }
}