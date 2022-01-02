import 'package:e_store_space/view/product/product_detail_screen.dart';
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

class HomeScreenTab extends StatelessWidget {

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
                background: Image.asset("assets/image/shirt.jpg", fit: BoxFit.cover,),
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
                          width: 250.w,
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
                        const Icon(Icons.sort_outlined, color: Colors.white,),
                        const Icon(Icons.sort_outlined, color: Colors.white,),
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
                    child: GridView.builder(
                      itemCount: 25,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 1.1
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: MyProduct(index),
                        );
                      }
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  MyProduct(int index){
    return Padding(
      padding: EdgeInsets.all(10.0.w),
      child: GestureDetector(
        onTap: (){Get.to(() => ProductDetailsScreen());},
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: index%2==0 ? AssetImage( "assets/image/apple.jpg",) :  AssetImage( "assets/image/shoes.jpg",),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: Colors.blue,width: 2),
                color: Colors.lightGreen
              ),
              height: 230.h,
              width: 190.w,
            ),
            Container(
              height: 45.h,
              width: 190.w,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15.r),
                  bottomLeft: Radius.circular(15.r)
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left:15.0.w, right: 10.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h,),
                        Text('Product Name', style: TextStyle(color: Colors.white),),
                        Text('Price', style: TextStyle(color: Colors.white),),
                      ],
                    ),
                    const Text('Rating', style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
