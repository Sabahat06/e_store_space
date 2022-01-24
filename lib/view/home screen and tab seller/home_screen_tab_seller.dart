import 'package:carousel_pro/carousel_pro.dart';
import 'package:e_store_space/controller/user_store_controller.dart';
import 'package:e_store_space/models/get_store_product.dart';
import 'package:e_store_space/models/user_store.dart';
import 'package:e_store_space/view/product/product_detail_screen.dart';
import 'package:e_store_space/view/seller%20screens/store_product_seller.dart';
import 'package:e_store_space/view/seller%20screens/adding_deal.dart';
import 'package:e_store_space/widgets/my_appbar.dart';
import 'package:e_store_space/widgets/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/controller/cart/shop_cart_screen_controller.dart';
import 'package:e_store_space/controller/page_controller.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/statics/static_var.dart';
import 'package:e_store_space/view/search_screen.dart';
import 'package:e_store_space/widgets/my_category_box.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenTabSeller extends StatelessWidget {

  AuthController authController = Get.find();
  TextEditingController searchController = TextEditingController();
  BottomBarController bottomBarController = Get.find();

  RxInt currentIndex = 0.obs;
  RxList<String> splashData = [
    "assets/image/slider1.png",
    "assets/image/slider2.png",
    "assets/image/slider3.png"
  ].obs;

  RxList<String> banner = [
    "assets/image/banner1.png",
    "assets/image/banner2.png",
  ].obs;

  RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context){
    UserStoreController userStoreController = Get.put(UserStoreController());
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => isLoading.value || userStoreController.progressing.value
              ? Center(child: CircularProgressIndicator(),)
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      child: Carousel(
                          dotSize: 5,
                          autoplayDuration: Duration(seconds: 3),
                          dotSpacing: 10,
                          autoplay: true,
                          dotColor: Colors.white,
                          dotIncreasedColor: Colors.blue,
                          indicatorBgPadding: 5,
                          dotBgColor: Colors.transparent,
                          dotVerticalPadding: 5,
                          images: <Widget>[
                            for(var i=0; i<splashData.length; i++)
                              Container(
                                margin:
                                const EdgeInsets.only(top: 0.0, left: 0.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(splashData[i],),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          ]
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 45.h,
                            width: 70.w,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/image/appbar.jpg"),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          Container(
                              width: 290.w,
                              height: 45.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: searchController,
                                  decoration: const InputDecoration(
                                    hintText: "Search",
                                    prefixIcon: Icon(Icons.search),
                                    border: InputBorder.none,
                                  ),
                                ),
                              )
                          ),
                        ]
                    ),
                    const SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(child: Text('All Stores:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),),
                    ),
                    Obx(
                      () => userStoreController.userStore.value.store == null || userStoreController.userStore.value.store.length == 0
                      ? Center(child: Column(
                          children: [
                            SizedBox(height: 100,),
                            Text('No Store Added Yet Add Some', style: TextStyle(fontSize: 16.sp,),),
                            SizedBox(height: 100,),
                          ],
                        ),
                      )
                      : SingleChildScrollView(
                          child: Container(
                            width: double.infinity,
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 1.1
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: userStoreController.userStore.value.store.length,
                              itemBuilder: (BuildContext context, int index) {
                                return renderingStore(index, userStoreController.userStore.value.store[index], context);
                              }
                            )
                          ),
                        ),
                    ),
                    Container(
                      height: 150,
                      width: double.infinity,
                      child: Carousel(
                          dotSize: 0,
                          autoplayDuration: Duration(seconds: 3),
                          dotSpacing: 10,
                          autoplay: true,
                          dotColor: Colors.white,
                          dotIncreasedColor: Colors.blue,
                          indicatorBgPadding: 5,
                          dotBgColor: Colors.transparent,
                          dotVerticalPadding: 5,
                          images: <Widget>[
                            for(var i=0; i<banner.length; i++)
                              Container(
                                margin:
                                const EdgeInsets.only(top: 0.0, left: 0.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(banner[i],),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          ]
                      ),
                    ),
                  ],
          ),
              )
        ),
        floatingActionButton: GestureDetector(
          onTap: (){Get.to(() => AddingStoreScreen());},
          child: Container(
            height: 40.h,
            width: 130.w,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Text(
                'Add Store',
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  renderingStore(int index, Store store, BuildContext context){
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      child: Container(
        height: 80,
        width: 100,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage('https://spinningsoft.co/projects/eStoreSpace/admin/images/store/${store.picture}'),
              backgroundColor: store.picture == '' ? index%2!=0 ? Colors.green : Colors.redAccent : Colors.transparent,
            ),
            const SizedBox(height: 5,),
            Text('${store.dealType}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
          ],
        ),
      ),
    );
  }

}
