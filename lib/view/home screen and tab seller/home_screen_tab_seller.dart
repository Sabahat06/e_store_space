import 'package:e_store_space/view/product/product_detail_screen.dart';
import 'package:e_store_space/view/product/store_dart.dart';
import 'package:e_store_space/widgets/my_appbar.dart';
import 'package:e_store_space/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/controller/cart/shop_cart_screen_controller.dart';
import 'package:e_store_space/controller/category_controller.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/statics/static_var.dart';
import 'package:e_store_space/view/product/cart_screen.dart';
import 'package:e_store_space/view/search_screen.dart';
import 'package:e_store_space/widgets/my_category_box.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenTabSeller extends StatelessWidget {

  TextEditingController searchController = TextEditingController();
  BottomBarController bottomBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 210.0.h,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset("assets/image/appimage.jpeg", fit: BoxFit.cover,),
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
              SliverList(
                delegate: SliverChildListDelegate([
                  SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 7,
                        itemBuilder: (BuildContext context, int index) {
                          return renderingStore(index, context);
                        }
                      )
                    ),
                  ),
                ]),
              )
            ],
          )
      ),
    );
  }

  renderingStore(int index, BuildContext context) {
    return GestureDetector(
      onTap: (){Get.to(() => StoreProducts());},
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
        child: Card(
          color: Colors.green,
          elevation: 16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 85.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Text("Store Name", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
                  ),
                  SizedBox(height: 5.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 300.w,
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(child: Text("Store Product Short Details", style: TextStyle(fontSize: 14.sp, color: Colors.black54), maxLines: 3,)),
                              SizedBox(height: 5.h,),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 12.0.w),
                                    child: Container(
                                        color: Colors.blue,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text("Store Status",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        )
                                    )
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
