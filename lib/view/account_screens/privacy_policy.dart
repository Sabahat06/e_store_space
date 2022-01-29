import 'package:e_store_space/controller/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatelessWidget {

  HtmlPageController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
          leadingWidth: 30,
          title: const Text('Privacy Policy', style: TextStyle(color: Colors.white),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 5,
            color: Colors.white,
            child: Html(
              style: {'html': Style(textAlign: TextAlign.justify, color: Colors.black)},
              data: controller.privacyPolicy,
            ),
          ),
        )
    );
  }
}
