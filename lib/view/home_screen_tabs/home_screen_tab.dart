import 'package:carousel_pro/carousel_pro.dart';
import 'package:e_store_space/controller/product_category_controller.dart';
import 'package:e_store_space/models/get_store_product.dart';
import 'package:e_store_space/models/latest_store_model.dart';
import 'package:e_store_space/models/product_category_model.dart';
import 'package:e_store_space/models/product_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/view/product/product_detail_screen.dart';
import 'package:e_store_space/view/product/product_screen.dart';
import 'package:e_store_space/view/product/store_product.dart';
import 'package:e_store_space/view/seller%20screens/product_category_screen.dart';
import 'package:e_store_space/view/seller%20screens/store_product_seller.dart';
import 'package:e_store_space/widgets/my_appbar.dart';
import 'package:e_store_space/widgets/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/bottom_bar_controller.dart';

class HomeScreenTab extends StatelessWidget {
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

  TextEditingController searchController = TextEditingController();
  BottomBarController bottomBarController = Get.find();
  ProductCategoryController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Container(
                height: 150,
                width: double.infinity,
                child: Obx(
                  () => controller.storeProgressing.value
                      ? Center(child: CircularProgressIndicator(),)
                      : controller.latestAndStoreModel.value.homeScreenStore == null || controller.latestAndStoreModel.value.homeScreenStore.length == 0
                        ?  Center(child: Text("There is No Store Here", style: TextStyle(color: Colors.black, fontSize: 16.sp),),)
                        :  ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.latestAndStoreModel.value.homeScreenStore.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index){
                              return renderingstoreProduct(index, controller.latestAndStoreModel.value.homeScreenStore[index]);
                            },
                          ),
                ),
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(child: Text('Latest Stores:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),),
              ),
              Container(
                height: 150,
                width: double.infinity,
                child: Obx(
                  () => controller.storeProgressing.value
                    ? Center(child: CircularProgressIndicator(),)
                    : controller.latestAndStoreModel.value.latestStore==null || controller.latestAndStoreModel.value.latestStore.length == 0
                      ? Center(child: Text("There is No Latest Store Here", style: TextStyle(color: Colors.black, fontSize: 16.sp),),)
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.latestAndStoreModel.value.latestStore.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index){
                            return storeLatestProducts(index, controller.latestAndStoreModel.value.latestStore[index]);
                          },
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
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 5),
                child: Container(child: Text('Categories: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),),
              ),
              Container(
                width: double.infinity,
                child: Obx(
                  () => controller.progressing.value
                      ? Center(child: CircularProgressIndicator(),)
                      :  GridView.builder(
                    itemCount: controller.productCategory.value.productCategoryModel.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 1.1
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: MyCategory(context, index, controller.productCategory.value.productCategoryModel[index]),
                      );
                    }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  MyCategory(BuildContext context, int index, ProductCategoryModel productCategoryModel){
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        Get.to(() => ProductScreen(categoryId: productCategoryModel.id.toString(), title: productCategoryModel.name,));
      },
      child: Padding(
        padding: EdgeInsets.all(8),
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

  renderingstoreProduct(int index, HomeScreenStore store){
    return GestureDetector(
      onTap: () async {
        controller.progressing.value = true;
        ProductModel productModel = await  HttpService.getProductOfStore(store.id.toString());
        controller.progressing.value = false;
        Get.to(() => StoreProductScreen(productModel: productModel, title: store.name,));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
        child: Container(
          height: 70,
          width: 100,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage('https://spinningsoft.co/projects/eStoreSpace/admin/images/store/${store.picture}'),
                backgroundColor: store.picture == '' ? index%2!=0 ? Colors.green : Colors.redAccent : Colors.transparent,
              ),
              SizedBox(height: 5,),
              Text('${store.dealType}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ],
          ),
        ),
      ),
    );
  }

  storeLatestProducts(int index, LatestStore store){
    return GestureDetector(
      onTap: () async {
          controller.progressing.value = true;
          ProductModel productModel = await  HttpService.getProductOfStore(store.id.toString());
          controller.progressing.value = false;
          Get.to(() => StoreProductScreen(productModel: productModel, title: store.name,));
        },
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
        child: Container(
          height: 70,
          width: 100,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage('https://spinningsoft.co/projects/eStoreSpace/admin/images/store/${store.picture}'),
                backgroundColor: store.picture == '' ? index%2==0 ? Colors.green : Colors.redAccent : Colors.transparent,
              ),
              SizedBox(height: 5,),
              Text('${store.dealType}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ],
          ),
        ),
      ),
    );
  }
}
