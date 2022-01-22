import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreenTabSeller extends StatelessWidget {
  BottomBarController bottomBarController = Get.find();
  RxInt quantity = 0.obs;
  @override

  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white, iconSize: 0,),
          leadingWidth: 5,
          centerTitle: true,
          title: Text("Notification", style: TextStyle(fontSize: 16.sp, color: Colors.white),),
        ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return renderingNotification(index, context);
            }
          )
        ),
      ),
    );
  }


  renderingNotification(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 10),
      child: Card(
        color: Colors.green,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          // height: 85.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.black26,
                  width: double.infinity,
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5, top: 2, bottom: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Store ${index}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.blue), textAlign: TextAlign.left,),
                        Text("6:00 PM", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.blue), textAlign: TextAlign.left,),
                      ],
                    ),
                  )
                ),
                SizedBox(height: 5.h,),
                Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    // height: 50.h,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5, top: 2, bottom: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Our New Winter Collection is In! Come By 36th Street to see it by yourself", style: TextStyle(fontSize: 16.sp, color: Colors.black), textAlign: TextAlign.left,),
                          SizedBox(height: 4.h,),
                          Text("SHOP NOW", style: TextStyle(fontSize: 12.sp, color: Colors.black54), textAlign: TextAlign.left,),
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
