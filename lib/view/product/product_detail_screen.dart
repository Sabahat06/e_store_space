import 'package:e_store_space/controller/cart/shop_cart_screen_controller.dart';
import 'package:e_store_space/controller/product_detials_controller.dart';
import 'package:e_store_space/controller/wish_list_controller.dart';
import 'package:e_store_space/models/cart/new_cart_model.dart';
import 'package:e_store_space/models/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductDetailsScreen extends StatelessWidget {
  WishListController wishListController = Get.find();
  CartControllerNew cartControllerNew = Get.find();
  ProductDetailsModel productDetailsModel;

  ProductDetailsScreen({@required this.productDetailsModel}) {}
  List<String> productImages = ['assets/image/image6.jpg', 'assets/image/appbar.jpg', 'assets/image/appimage.jpeg', 'assets/image/image6.jpg'];
  List<int> colorCode = [0xff039e2c, 0xffDEDEDE, 0xffffb852, 0xffe95a5c];
  RxInt choiceid = 0.obs;
  RxInt quantity = 0.obs;
  RxBool isExpanded = false.obs;
  RxString subCategoryImages=''.obs;

  @override
  Widget build(BuildContext context) {
    cartControllerNew.currentChoiceID.value = productDetailsModel.productDetails.productColors.first.colorId;
    subCategoryImages.value = "https://spinningsoft.co/projects/eStoreSpace/admin/images/product_images/${productDetailsModel.productDetails.productColors.first.image}";
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Obx(
                        () => Container(
                          width: double.infinity,
                          height: 240.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(subCategoryImages.value),
                              fit: BoxFit.contain,
                            )
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        left: 20,
                        child: Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20,),onPressed: (){Get.back();},),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 10,
                        child: Container(
                          height: 30.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: Text(double.parse(productDetailsModel.rating).toStringAsFixed(1), style: TextStyle(fontSize: 16.sp, color: Colors.black),),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 70.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          itemBuilder: (context, index){
                            return subCategoriesImages(productDetailsModel.productDetails.productColors[index] ,index);
                          },
                          itemCount: productDetailsModel.productDetails.productColors.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                        )
                      ],
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15)
                          ),
                          color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left:10, top: 10,bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(productDetailsModel.productDetails.name, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                  Row(
                                    children: [
                                      Text('More Detail', style: TextStyle(fontSize: 16.sp, color: Colors.blue),),
                                      IconButton(
                                        onPressed: () {
                                          isExpanded.value = !isExpanded.value;
                                        },
                                        icon: Icon(isExpanded.value ? Icons.expand_less_outlined : Icons.expand_more_outlined, color: Colors.blue,)
                                      )
                                    ],
                                  ),
                                  isExpanded.value
                                    ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 220.w,
                                          child: Text(productDetailsModel.productDetails.description),
                                        ),
                                        const SizedBox(height: 7,),
                                        Row(
                                          children: [
                                            SmoothStarRating(
                                              color: Colors.purpleAccent,
                                              rating: double.parse(productDetailsModel.rating),
                                              size: 15,
                                              isReadOnly: true,
                                              borderColor: Colors.purpleAccent,
                                            ),
                                            const SizedBox(width: 7,),
                                            Text(double.parse(productDetailsModel.rating).toStringAsFixed(1), style: TextStyle(fontSize: 15, color: Colors.black54),),
                                          ],
                                        ),
                                      ],
                                    )
                                    : Container()
                                ],
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)
                                  ),
                                  color: Colors.transparent
                                ),
                                width: 85.w,
                                height: 60.h,
                                child: Center(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          wishListController.items.any((element) => element.productDetails.id==productDetailsModel.productDetails.id)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        onPressed: (){
                                          wishListController.addOrRemoveItem(productDetailsModel);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.share_outlined,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Icon(
                                  //   Icons.favorite, size: 30, color: Colors.red,
                                  // ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)
                        ),
                        color: Colors.blue.shade100,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10.0, right: 10),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                                color: Colors.blue.shade100,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left:15, right: 15, top: 15, bottom: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 40.w,
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.blue, width: 2),
                                          ),
                                          child: const Center(
                                            child: Icon(Icons.location_city_outlined, color: Colors.blue,),
                                          ),
                                        ),
                                        SizedBox(width: 10.w,),
                                        Text("Taxial", style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      children: [
                                        Container(
                                          width: 40.w,
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Colors.blue, width: 2),
                                          ),
                                          child: const Center(
                                            child: Icon(Icons.lock_clock_outlined, color: Colors.blue,),
                                          ),
                                        ),
                                        SizedBox(width: 10.w,),
                                        Text("Delivery Time", style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Container(
                                      height: 40.h,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Center(child: Text('Color', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.blue), textAlign: TextAlign.center,)),
                                          ListView.builder(
                                            itemBuilder: (context, index){
                                              return renderingColors(productDetailsModel.productDetails.productColors[index] ,index);
                                            },
                                            itemCount: productDetailsModel.productDetails.productColors.length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('No. of Item in Cart', style: TextStyle(fontSize: 14.sp, color: Colors.black),),
                                        Obx(
                                          () => Row(
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  productDetailsModel.productDetails.quantity.value--;
                                                  if(productDetailsModel.productDetails.quantity.value<=0){
                                                    productDetailsModel.productDetails.quantity.value=0;
                                                  }
                                                },
                                                child: Container(
                                                  width: 25.w,
                                                  height: 25.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20.r),
                                                      color: Colors.white
                                                  ),
                                                  child: Icon(Icons.remove, size: 20.w, color: Colors.blue,),
                                                ),
                                              ),
                                              SizedBox(width: 10.w,),
                                              productDetailsModel.productDetails.quantity.value <=0 ? Text('0', style: TextStyle(fontSize: 14.sp, color: Colors.black),) : Text(productDetailsModel.productDetails.quantity.value.toString(), style: TextStyle(fontSize: 14.sp, color: Colors.black), ),
                                              SizedBox(width: 10.w,),
                                              GestureDetector(
                                                onTap: () {
                                                  productDetailsModel.productDetails.quantity.value++;
                                                },
                                                child: Container(
                                                  width: 25.w,
                                                  height: 25.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20.r),
                                                    color: Colors.white
                                                  ),
                                                  child: Icon(Icons.add, size: 25.w, color: Colors.blue,),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5.h,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              height: 65.h,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)
                                )
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 25.w),
                                child: GestureDetector(
                                  onTap: (){
                                    if(productDetailsModel.productDetails.quantity.value==0){
                                      Fluttertoast.showToast(msg: "Please Select Quantity");
                                    }else{
                                      Map json = productDetailsModel.productDetails.toJson();
                                      // json['choiceID'] = cartControllerNew.currentChoiceID.value;
                                      // json['quantity'] = productDetailsModel.productDetails.quantity.value;
                                      Item item = Item.fromJson(json);
                                      item.quantity.value = productDetailsModel.productDetails.quantity.value;
                                      item.choiceID = cartControllerNew.currentChoiceID.value;
                                      cartControllerNew.addItem(item);
                                    }
                                  },
                                  child: Container(
                                      height: 35.h,
                                      color: Colors.blue,
                                      width: double.infinity,
                                      child: const Center(
                                        child: Text('Add To Bag', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
                                      )
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  subCategoriesImages(ProductColors productColors ,int index){
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 10,),
        child: CircleAvatar(
          radius: 25,
          backgroundColor: choiceid.value == index ? Colors.blue : Colors.transparent,
          child: GestureDetector(
            onTap: (){
              choiceid.value = index;
              subCategoryImages.value = "https://spinningsoft.co/projects/eStoreSpace/admin/images/product_images/${productColors.image}";
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://spinningsoft.co/projects/eStoreSpace/admin/images/product_images/${productColors.image}"),
              radius: 23,
            ),
          ),
        ),
      ),
    );
  }

  renderingColors(ProductColors productColors,int index){
    String valueString = productColors.color.colorCode.replaceAll('#', "0xff");
    String valueString1 = valueString.replaceAll('\r', "");
    String valueString2 = valueString1.replaceAll('\n', "");
    int colorCodesss = int.parse(valueString2.toString());
    print(colorCodesss);
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: cartControllerNew.colorCodeid.value == index ? Colors.blue : Colors.transparent,
          child: GestureDetector(
            onTap: (){
              cartControllerNew.colorCodeid.value = index;
              cartControllerNew.currentChoiceID.value = productColors.colorId.toString();
            },
            child: CircleAvatar(
              backgroundColor: Color(colorCodesss),
              radius: 18,
            ),
          ),
        ),
      ),
    );
  }
}
