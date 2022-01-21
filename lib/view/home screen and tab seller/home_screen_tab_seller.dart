import 'package:carousel_pro/carousel_pro.dart';
import 'package:e_store_space/controller/user_store_controller.dart';
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

  TextEditingController searchController = TextEditingController();
  BottomBarController bottomBarController = Get.find();

  RxInt currentIndex = 0.obs;
  RxList<String> splashData = [
    "assets/image/shirt.jpg",
    "assets/image/logo.png",
    "assets/image/shoes.jpg"
  ].obs;

  @override
  Widget build(BuildContext context){
    UserStoreController userStoreController = Get.put(UserStoreController());
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => userStoreController.progressing.value
              ? Center(child: CircularProgressIndicator(),)
              : CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 210.0.h,
                flexibleSpace: FlexibleSpaceBar(
                  background: Carousel(
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
              ),
              SliverAppBar(
                backgroundColor: Colors.blue,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsetsDirectional.only(
                    start: 5.0,
                    bottom: 5.0,
                    top: 5,
                    end: 5
                  ),
                  centerTitle: true,
                  title: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 70.h,
                            width: 50.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/image/appbar.jpg"),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                          Container(
                              width: 290.w,
                              height: 70.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                controller: searchController,
                                decoration: const InputDecoration(
                                  hintText: "Search",
                                  prefixIcon: Icon(Icons.search),
                                  border: InputBorder.none,
                                ),
                              )
                          ),
                          // const Icon(Icons.sort_outlined, color: Colors.white,),
                          // const Icon(Icons.sort_outlined, color: Colors.white,),
                        ]
                    ),
                  ),
                ),
              ),
              Obx(
                () => userStoreController.userStore.value.store == null || userStoreController.userStore.value.store.length == 0
                      ? SliverList(delegate: SliverChildListDelegate([
                          Center(child: Column(
                            children: [
                              SizedBox(height: 200,),
                              Text('No Deal Added Yet Add Some', style: TextStyle(fontSize: 16.sp,),),
                            ],
                          ),)
                       ]))
                      : SliverList(
                  delegate: SliverChildListDelegate([
                    SingleChildScrollView(
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
                  ]),
                ),
              )
            ],
          ),
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
                'Add Deal',
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
      padding: EdgeInsets.all(10.0.w),
      child: GestureDetector(
        onTap: (){Get.to(() => StoreProductsSeller());},
        child: Card(
          elevation: 2,
          child: Container(
            height: width*0.5,
            // width: width*0.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100],
              // border: Border.all(color: Colors.grey),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: const Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: width*0.35,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Image.asset("assets/image/apple.jpg", fit: BoxFit.cover,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10,top: 5),
                        child:  Text(store.name,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,top: 5),
                      child: Text('2 Products',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
