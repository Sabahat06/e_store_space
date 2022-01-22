import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/controller/user_store_controller.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/view/account_screens/became_a_seller.dart';
import 'package:e_store_space/view/account_screens/privacy_policy.dart';
import 'package:e_store_space/view/account_screens/term_and_condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/view/account_screens/contact_us.dart';
import 'package:e_store_space/view/account_screens/dashboard_screen.dart';
import 'package:e_store_space/view/account_screens/order_histroy_screen.dart';
import 'package:e_store_space/view/auth%20screen/create_account.dart';
import 'package:e_store_space/view/auth%20screen/faq_sqreen.dart';
import 'package:e_store_space/view/auth%20screen/sign_in_screen.dart';
import 'package:e_store_space/view/auth%20screen/update_profile.dart';
import 'package:e_store_space/widgets/AlertDialogeWidget.dart';
import 'package:e_store_space/widgets/my_filled_button.dart';

import 'cart_screen_tab.dart';

class AccountScreenTab extends StatelessWidget {
  BottomBarController bottomBarController = Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white, iconSize: 0,),
            leadingWidth: 5,
            title: const Text('Account', style: TextStyle(color: Colors.white),),
          ),
          body: Obx(
            () => authController.isLogedIn.value
            ? SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Switch to Selling',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: Colors.black
                          ),
                        ),
                        Obx(
                          () => IconButton(
                            onPressed: () async {
                              if(bottomBarController.isSeller.value){
                                // UserStoreController userStoreController = UserStoreController();
                                // userStoreController.userStore = await HttpService.getUserStore(token: authController.user.value.token);
                                bottomBarController.isSeller.value =!bottomBarController.isSeller.value;
                              }
                              else{
                                bottomBarController.isSeller.value =!bottomBarController.isSeller.value;
                              }
                              // userStoreController.userStore = await HttpService.getUserStore(token: authController.user.value.token);
                              // bottomBarController.isSeller.value =!bottomBarController.isSeller.value;
                            },
                            icon: bottomBarController.isSeller.value
                                ? const Icon(Icons.toggle_on_outlined, size: 35, color: Colors.blue,)
                                : const Icon(Icons.toggle_off_outlined, size: 35, color: Colors.blue,),
                          ),
                        ),

                      ]
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Switch to Affiliate',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: Colors.black
                            ),
                          ),
                          Obx(
                            () => IconButton(
                              onPressed: () {
                                if(bottomBarController.isAffiliate.value){
                                  bottomBarController.isAffiliate.value =!bottomBarController.isAffiliate.value;
                                }
                                else{
                                  bottomBarController.isAffiliate.value =!bottomBarController.isAffiliate.value;
                                }
                              },
                              icon: bottomBarController.isAffiliate.value
                                  ? const Icon(Icons.toggle_on_outlined, size: 35, color: Colors.blue,)
                                  : const Icon(Icons.toggle_off_outlined, size: 35, color: Colors.blue,),
                            ),
                          ),

                        ]
                    ),
                    SizedBox(height: 10.h,),
                    GestureDetector(
                        onTap: () {
                          Get.to(() => BecomeASeller());
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.dashboard_outlined,),
                            const SizedBox(width: 10,),
                            Container(
                              width: Get.width-65,
                              child: const Text(
                                'Became a Seller',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                    // SizedBox(height: 15.h,),
                    // const Divider(),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.to(() => DashboardScreen());
                    //   },
                    //   child: Row(
                    //     children: [
                    //       const Icon(Icons.dashboard_outlined,),
                    //       const SizedBox(width: 10,),
                    //       Container(
                    //         width: Get.width-65,
                    //         child: const Text(
                    //           'My Dashboard',
                    //           style: TextStyle(
                    //             fontSize: 20,
                    //             color: Colors.black
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   )
                    // ),
                    SizedBox(height: 15.h,),
                    const Divider(),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => OrderHistoryScreen());
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
                    SizedBox(height: 15.h,),
                    const Divider(),
                    GestureDetector(
                      onTap: () {Get.to(UpdateProfile());},
                      child: Row(
                          children: [
                            const Icon(Icons.account_circle_outlined,),
                            const SizedBox(width: 10,),
                            Container(
                              width: Get.width-65,
                              child: const Text(
                                'Profile',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                    SizedBox(height: 15.h,),
                    const Divider(),
                    // GestureDetector(
                    //     onTap: () {
                    //       // Get.to(MyUsedMobileScreen());
                    //     },
                    //     child: Row(
                    //       children: [
                    //         const Icon(Icons.phone_iphone,),
                    //         const SizedBox(width: 10,),
                    //         Container(
                    //           width: Get.width-65,
                    //           child: const Text(
                    //             'My Used Devices',
                    //             style: TextStyle(
                    //               color: Colors.black,
                    //               fontSize: 20,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     )
                    // ),
                    // const SizedBox(height: 15,),
                    // const Divider(),
                    GestureDetector(
                        onTap: () {
                          Get.to(FAQScreen());
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
                    SizedBox(height: 15.h,),
                    const Divider(),
                    GestureDetector(
                        onTap: () {Get.to(PrivacyPolicy());},
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
                    SizedBox(height: 15.h,),
                    const Divider(),
                    GestureDetector(
                        onTap: () {Get.to(TermAndCondition());},
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
                    SizedBox(height: 15.h,),
                    const Divider(),
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
                    SizedBox(height: 20.h,),
                    GestureDetector(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialogWidget(
                                title: 'Log Out Alert',
                                subTitle: "Are you sure to logout?",
                                onPositiveClick: () {
                                  // isLogedIn.value = false;
                                  authController.logOut();
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
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h,),
                      GestureDetector(
                          onTap: () {Get.to(ContactUs());},
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
                      SizedBox(height: 15.h,),
                      GestureDetector(
                          onTap: () {Get.to(FAQScreen());},
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
                      SizedBox(height: 15.h,),
                      GestureDetector(
                          onTap: () {Get.to(PrivacyPolicy());},
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
                      SizedBox(height: 15.h,),
                      GestureDetector(
                        onTap: () {Get.to(TermAndCondition());},
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
                      SizedBox(height: 15.h,),
                      MyFilledButton(
                        ontap: () {
                          Get.to(() => CreateAccount(false));
                        },
                        color: Colors.blue,
                        width: double.infinity,
                        txt: 'Create Account',
                        borderRadius: 10.r,
                        fontSize: 20.sp,
                      ),
                      const SizedBox(height: 15,),
                      MyFilledButton(
                        ontap: () {
                          Get.to(SignInScreen());
                        },
                        color: Colors.blue,
                        width: double.infinity,
                        txt: 'Sign In',
                        borderRadius: 10.r,
                        fontSize: 20.sp,
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