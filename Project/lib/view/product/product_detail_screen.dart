import 'package:e_store_space/controller/wish_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatelessWidget {
  WishListController wishListController = Get.find();
  // Products products;
  //
  // ProductDetailsScreen({@required this.products}) {
  //   productDetailsController.totalPrice.value = int.parse(products.salePrice);
  // }
  List<String> productImages = ['assets/image/image6.jpg', 'assets/image/appbar.jpg', 'assets/image/appimage.jpeg', 'assets/image/image6.jpg'];
  List<int> colorCode = [0xff039e2c, 0xffDEDEDE, 0xffffb852, 0xffe95a5c];
  RxInt choiceid = 0.obs;
  RxInt colorCodeid = 0.obs;
  RxInt quantity = 0.obs;
  RxBool isExpanded = false.obs;

  @override
  Widget build(BuildContext context) {
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
                              image: AssetImage(productImages[choiceid.value]),
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
                            child: Text('4.5', style: TextStyle(fontSize: 16.sp, color: Colors.black),),
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
                            return subCategoriesImages(productImages[index] ,index);
                          },
                          itemCount: productImages.length,
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
                                  Text('Product Name', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
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
                                    ? Container(
                                        width: 250.w,
                                        child: Text('Steel Series Architec, Gaming Phone Head set'),
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
                                width: 60.w,
                                height: 60.h,
                                child: Center(
                                  child:
                                  // IconButton(
                                  //   icon: Icon(
                                  //     wishListController.items.any((element) => element.id==product.id)
                                  //         ? Icons.favorite
                                  //         : Icons.favorite_border,
                                  //     color: AppColors.primaryColor,),
                                  //   onPressed: (){
                                  //     wishListController.addOrRemoveItem(product);
                                  //   },
                                  // ),
                                  Icon(
                                    Icons.favorite, size: 30, color: Colors.red,
                                  ),
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
                                              return renderingColors(colorCode[index] ,index);
                                            },
                                            itemCount: colorCode.length,
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
                                                  quantity.value--;
                                                  if(quantity.value<=0){
                                                    quantity.value=0;
                                                  }
                                                },
                                                child: Container(
                                                  width: 25.w,
                                                  height: 25.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20.r),
                                                      color: Colors.transparent
                                                  ),
                                                  child: Icon(Icons.remove, size: 20.w, color: Colors.blue,),
                                                ),
                                              ),
                                              SizedBox(width: 10.w,),
                                              quantity.value <=0 ? Text('') : Text(quantity.value.toString(), style: TextStyle(fontSize: 14.sp, color: Colors.black), ),
                                              SizedBox(width: 10.w,),
                                              GestureDetector(
                                                onTap: () {
                                                  quantity.value++;
                                                },
                                                child: Container(
                                                  width: 25.w,
                                                  height: 25.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20.r),
                                                      color: Colors.transparent
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

  subCategoriesImages(String images ,int index){
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 10,),
        child: CircleAvatar(
          radius: 25,
          backgroundColor: choiceid.value == index ? Colors.blue : Colors.transparent,
          child: GestureDetector(
            onTap: (){
              choiceid.value = index;
            },
            child: CircleAvatar(
              backgroundImage: AssetImage(images),
              radius: 23,
            ),
          ),
        ),
      ),
    );
  }

  renderingColors(int colorcode,int index){
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: colorCodeid.value == index ? Colors.blue : Colors.transparent,
          child: GestureDetector(
            onTap: (){
              colorCodeid.value = index;
            },
            child: CircleAvatar(
              backgroundColor: Color(colorcode),
              radius: 18,
            ),
          ),
        ),
      ),
    );
  }
}
