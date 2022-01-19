import 'package:e_store_space/controller/user_store_controller.dart';
import 'package:e_store_space/models/user_store.dart';
import 'package:e_store_space/view/product/product_detail_screen.dart';
import 'package:e_store_space/view/seller%20screens/store_product_seller.dart';
import 'package:e_store_space/view/seller%20screens/adding_deal.dart';
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

class HomeScreenTabSeller extends StatelessWidget {

  UserStoreController userStoreController = UserStoreController();

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
            userStoreController.userStore.store == null || userStoreController.userStore.store.length == 0
                ? Center(child: Text('No Deal Added Yet Add Some', style: TextStyle(fontSize: 16.sp,),),)
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
                      itemCount: userStoreController.userStore.store.length,
                      itemBuilder: (BuildContext context, int index) {
                        return renderingStore(index, userStoreController.userStore.store[index]);
                      }
                    )
                  ),
                ),
              ]),
            )
          ],
        ),
        floatingActionButton: GestureDetector(
          onTap: (){Get.to(() => AddingDealScreen());},
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

  renderingStore(int index, Store store){
    return Padding(
      padding: EdgeInsets.all(10.0.w),
      child: GestureDetector(
        onTap: (){Get.to(() => StoreProductsSeller());},
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
                    Text(store.name, style: const TextStyle(color: Colors.white),),
                    Text(store.description, style: const TextStyle(color: Colors.blue),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // renderingStore(int index, BuildContext context) {
  //   return GestureDetector(
  //     onTap: (){Get.to(() => StoreProductsSeller());},
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
  //       child: Card(
  //         color: Colors.green,
  //         elevation: 16,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: Container(
  //           height: 85.h,
  //           width: double.infinity,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(5),
  //             color: Colors.white,
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Container(
  //                     child: Text("Store Name", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
  //                 ),
  //                 SizedBox(height: 5.h,),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     Container(
  //                       width: 300.w,
  //                       padding: const EdgeInsets.only(bottom: 4.0),
  //                       child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Container(child: Text("Store Product Short Details", style: TextStyle(fontSize: 14.sp, color: Colors.black54), maxLines: 3,)),
  //                             SizedBox(height: 5.h,),
  //                             Row(
  //                               children: [
  //                                 Padding(
  //                                   padding: EdgeInsets.only(right: 12.0.w),
  //                                   child: Container(
  //                                       color: Colors.blue,
  //                                       child: Padding(
  //                                         padding: const EdgeInsets.all(5.0),
  //                                         child: Text("Store Status",
  //                                           style: TextStyle(
  //                                             fontSize: 14.sp,
  //                                             fontWeight: FontWeight.bold
  //                                           ),
  //                                         ),
  //                                       )
  //                                   )
  //                                 ),
  //                               ],
  //                             ),
  //                           ],
  //                         )
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
