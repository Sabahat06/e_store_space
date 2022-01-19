import 'package:e_store_space/controller/product_category_controller.dart';
import 'package:e_store_space/models/product_category_model.dart';
import 'package:e_store_space/view/product/product_detail_screen.dart';
import 'package:e_store_space/view/product/product_screen.dart';
import 'package:e_store_space/view/seller%20screens/store_product_seller.dart';
import 'package:e_store_space/widgets/my_appbar.dart';
import 'package:e_store_space/widgets/my_text_field.dart';
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

class HomeScreenTab extends StatelessWidget {

  TextEditingController searchController = TextEditingController();
  BottomBarController bottomBarController = Get.find();
  ProductCategoryController controller = Get.find();

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
                      child: Obx(
                        () => GridView.builder(
                          itemCount: controller.productCategory.value.productCategoryModel.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 1.1
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: MyProduct(context, index, controller.productCategory.value.productCategoryModel[index]),
                            );
                          }
                        ),
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

  MyProduct(BuildContext context, int index, ProductCategoryModel productCategoryModel){
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        Get.to(() => ProductScreen(categoryId: productCategoryModel.id.toString(), title: productCategoryModel.name,));
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          elevation: 3,
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
                  child: Image.network("https://spinningsoft.co/projects/eStoreSpace/admin/images/product_category/${productCategoryModel.picture}", fit: BoxFit.cover,),
                ),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10,top: 5),
                      child:  Text(productCategoryModel.name,style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

}
