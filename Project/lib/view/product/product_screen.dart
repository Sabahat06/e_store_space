import 'package:e_store_space/view/product/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/product_controller.dart';


class ProductScreen extends StatelessWidget {
  RxString id = '0'.obs;
  String subCategoryID;
  int pageNo;
  String title;
  ProductController productController;

  ProductScreen({this.subCategoryID, this.pageNo, this.title}){
    productController =Get.put(ProductController(subCategoryID: subCategoryID,pageNo: pageNo));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: const Text('Category Title', style: TextStyle(color: Colors.white),),
      ),
      body: GridView.builder(
          itemCount: 25,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 1.1
          ),
          itemBuilder: (BuildContext context, int index) {
            return renderingProduct(index);
          }
      ),
    );
  }

  renderingProduct(int index) {
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