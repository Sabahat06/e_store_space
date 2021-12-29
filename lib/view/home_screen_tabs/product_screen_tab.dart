import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/cart/shop_cart_screen_controller.dart';
import 'package:e_store_space/controller/cart_controller.dart';
import 'package:e_store_space/controller/category_controller.dart';
import 'package:e_store_space/models/sub_category_model.dart';
import 'package:e_store_space/settings/color_palates.dart';
import 'package:e_store_space/view/product/cart_screen.dart';
import 'package:e_store_space/view/product/product_screen.dart';
import 'package:e_store_space/widgets/my_appbar.dart';

class ProductScreenTab extends StatelessWidget {

  // var categoriesController = Get.put(CategoriesController());
  var categoryController=Get.put(CategoryController());
  CartControllerNew cartController=Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => DefaultTabController(
        initialIndex: categoryController.currentTabIndex.value,
        length: categoryController.categories.length ?? 0,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Categories'),
            actions: [
              GestureDetector(
                onTap: ()=>Get.to(CartScreen()),
                child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.shopping_cart_outlined),
                          onPressed: () {
                            // Get.to(StepperBar());
                            Get.to(CartScreen());
                          },
                          color: Colors.black
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          cartController.cart.items.length == 0
                              ? Container()
                              : const Icon(
                            Icons.circle,
                            color: Colors.white,
                          ),
                          cartController.cart.items.length == 0
                              ?Container()
                              : Text(
                            (cartController.cart.items.length).toString(),
                            style: const TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ]
                ),
              )
            ],
            bottom: TabBar(
              onTap: (index) {
                categoryController.currentTabIndex.value = index;
              },
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 3.0,
              tabs: categoryController.categories.map(
                (category) => Tab(
                    child: Text(
                      category.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                    ),
                  )
              ).toList(),
            ),
          ),

          body:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: Get.height*0.71,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0
                      ),
                      // itemCount: categoriesController.categories.length,
                      itemCount: categoryController.categories[categoryController.currentTabIndex.value].subCategories.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return renderSubCategoryItem(context, categoryController.categories[categoryController.currentTabIndex.value].subCategories[index]);
                      }
                    ),
                  ),
                ),
              ],
            ),
          ) ,
        ),
      ),
    );
  }
  Widget renderSubCategoryItem(BuildContext context, SubCategoryModel model){
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){Get.to(()=>ProductScreen(model.id,1,model.title));},
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          height: width*0.45,
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
                offset: Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: width*0.35,
                  width: width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Image.network(model.image,)),
              const SizedBox(height: 5,),
              Center(
                child: Text(model.title,style: const TextStyle(fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),
      ),
    );
    return  GestureDetector(
      onTap: () {
        Get.to(()=>ProductScreen(model.id,1,model.title));
        // Get.to(DummyScreen());
      },
      child: Container(
        child: Center(
            child:  Text(
               model.title,
              style:const TextStyle(
                fontSize: 16,
                color: Colors.black ,
                fontWeight: FontWeight.bold,
              ),
            )
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
        ),
      ),
    );
  }
}
