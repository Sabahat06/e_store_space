import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/html_screen.dart';
import 'package:e_store_space/settings/color_palates.dart';
import 'package:e_store_space/update_prompt/update_prompt_screen.dart';
import 'package:e_store_space/view/account_screens/contact_us.dart';
import 'package:e_store_space/view/account_screens/dashboard_screen.dart';
import 'package:e_store_space/view/account_screens/order_histroy_screen.dart';
import 'package:e_store_space/view/auth%20screen/create_account.dart';
import 'package:e_store_space/view/auth%20screen/faq_sqreen.dart';
import 'package:e_store_space/view/auth%20screen/sign_in_screen.dart';
import 'package:e_store_space/view/auth%20screen/update_profile.dart';
import 'package:e_store_space/view/auth%20screen/sign_in_screen.dart';
import 'package:e_store_space/view/account_screens/my_used_mobile_screen.dart';
import 'package:e_store_space/widgets/AlertDialogeWidget.dart';
import 'package:e_store_space/widgets/my_appbar.dart';
import 'package:e_store_space/widgets/my_filled_button.dart';

import 'cart_screen_tab.dart';

class AccountScreenTab extends StatelessWidget {
  AuthController authController = Get.find();
  RxBool isLogedIn = false.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Obx(
            () => authController.isLogedIn.value
            ? SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // Get.to(() => DashboardScreen());
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
                const SizedBox(height: 15,),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    // Get.off(OrderHistoryScreen());
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.reorder_rounded,),
                      const SizedBox(width: 10,),
                      Container(
                        width: Get.width-65,
                        child: const Text(
                          'Orders History',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 15,),
                const Divider(),
                GestureDetector(
                  // onTap: () {Get.to(UpdateProfile());},
                  child: Row(
                      children: [
                        const Icon(Icons.account_circle_outlined,),
                        const SizedBox(width: 10,),
                        Container(
                          width: Get.width-65,
                          child: const Text(
                            'Account Details',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                const SizedBox(height: 15,),
                const Divider(),
                GestureDetector(
                    onTap: () {
                      // Get.to(MyUsedMobileScreen());
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.phone_iphone,),
                        const SizedBox(width: 10,),
                        Container(
                          width: Get.width-65,
                          child: const Text(
                            'My Used Devices',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                const SizedBox(height: 15,),
                const Divider(),
                GestureDetector(
                    onTap: () {
                      // Get.to(FAQScreen());
                    },
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
//                      letterSpacing: 2
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                const SizedBox(height: 15,),
                const Divider(),
                GestureDetector(
                    // onTap: () {Get.to(HtmlViewer("4"));},
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
                const SizedBox(height: 15,),
                const Divider(),
                GestureDetector(
                    // onTap: () {Get.to(HtmlViewer("5"));},
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
                const SizedBox(height: 15,),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    // Get.to(ContactUs());
                    // Get.to(ContactUs());
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
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return AlertDialogWidget(
                    //         title: 'Log Out Alert',
                    //         subTitle: "Are you sure to logout?",
                    //         onPositiveClick: () {
                    //           authController.logOut();
                    //           Get.back();
                    //         },
                    //       );
                    //     }
                    // );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorPalette.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 40,
                    width: double.infinity,
                    child: Center(
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


            : SingleChildScrollView(
                child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15,),
                GestureDetector(
                    // onTap: () {Get.to(ContactUs());},
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
                const SizedBox(height: 15,),
                GestureDetector(
                    // onTap: () {Get.to(FAQScreen());},
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
                const SizedBox(height: 15,),
                GestureDetector(
                    // onTap: () {Get.to(HtmlViewer("4"));},
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
                const SizedBox(height: 15,),
                GestureDetector(
                    // onTap: () {Get.to(HtmlViewer("5"));},
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
                const SizedBox(height: 15,),
                MyFilledButton(
                  ontap: () {
                    // Get.to(() => CreateAccount(false));
                  },
                  color: Colors.blue,
                  width: double.infinity,
                  txt: 'Create Account',
                  borderRadius: 10,
                ),
                const SizedBox(height: 15,),
                MyFilledButton(
                  ontap: () {
                    // Get.to(SignInScreen());
                  },
                  color: Colors.blue,
                  width: double.infinity,
                  txt: 'Sign In',
                  borderRadius: 10,
                ),
              ],
            ),
            ),
          ),
        )
      ),
    );
  }
}