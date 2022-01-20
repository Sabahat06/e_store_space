import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/view/account_screens/privacy_policy.dart';
import 'package:e_store_space/view/account_screens/term_and_condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/view/account_screens/contact_us.dart';
import 'package:e_store_space/view/account_screens/dashboard_screen.dart';
import 'package:e_store_space/view/auth%20screen/faq_sqreen.dart';
import 'package:e_store_space/widgets/AlertDialogeWidget.dart';

import 'notification_tab_seller.dart';

class AccountScreenTabSeller extends StatelessWidget {
  BottomBarController bottomBarController = Get.find();
  AuthController authController = Get.find();
  RxBool isLogedIn = true.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white, iconSize: 0,),
            leadingWidth: 5,
            title: const Text('Account', style: TextStyle(color: Colors.white),),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Is Seller',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            color: Colors.blue
                        ),
                      ),
                      Obx(
                            () => IconButton(
                          onPressed: (){
                            bottomBarController.isSeller.value =!bottomBarController.isSeller.value;
                          },
                          icon: bottomBarController.isSeller.value
                              ? const Icon(Icons.toggle_on_outlined, size: 35, color: Colors.blue,)
                              : const Icon(Icons.toggle_off_outlined, size: 35, color: Colors.blue,),
                        ),
                      ),

                    ]
                  ),
                  const Divider(),
                  SizedBox(height: 12.h,),
                  GestureDetector(
                      onTap: () {
                        Get.to(() => DashboardScreen());
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.dashboard_outlined,),
                          const SizedBox(width: 10,),
                          Container(
                            width: Get.width-65,
                            child: const Text(
                              'My Dashboard',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  const Divider(),
                  SizedBox(height: 12.h,),
                  GestureDetector(
                      onTap: () {
                        Get.to(ContactUs());
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.phone_in_talk_outlined,),
                          const SizedBox(width: 10,),
                          Container(
                            width: Get.width-65,
                            child: const Text(
                              'Contact Us',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  const Divider(),
                  SizedBox(height: 12.h,),
                  GestureDetector(
                      onTap: () {Get.to(() => FAQScreen());},
                      child: Row(
                        children: [
                          const Icon(Icons.help_outline_outlined,),
                          const SizedBox(width: 10,),
                          Container(
                            width: Get.width-65,
                            child: const Text(
                              'FAQs',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  const Divider(),
                  SizedBox(height: 12.h,),
                  GestureDetector(
                      onTap: () {Get.to(() => PrivacyPolicy());},
                      child: Row(
                        children: [
                          const Icon(Icons.library_books_outlined,),
                          const SizedBox(width: 10,),
                          Container(
                            width: Get.width-65,
                            child: const Text(
                              'Privacy Policy',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  const Divider(),
                  SizedBox(height: 12.h,),
                  GestureDetector(
                      onTap: () {Get.to(() => TermAndCondition());},
                      child: Row(
                        children: [
                          const Icon(Icons.description_outlined,),
                          const SizedBox(width: 10,),
                          Container(
                            width: Get.width-65,
                            child: const Text(
                              'Terms & Conditions',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  const Divider(),
                  SizedBox(height: 10.h,),
                  GestureDetector(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialogWidget(
                            title: 'Log Out Alert',
                            subTitle: "Are you sure to logout?",
                            onPositiveClick: () {
                              isLogedIn.value = false;
                              authController.logOut();
                              bottomBarController.isSeller.value =!bottomBarController.isSeller.value;
                              Get.back();
                            },
                          );
                        }
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 40,
                      width: double.infinity,
                      child: const Center(
                          child:  Text('Log Out',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}