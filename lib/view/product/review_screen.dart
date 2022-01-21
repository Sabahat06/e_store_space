import 'package:e_store_space/models/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewsScreen extends StatelessWidget {
  List<Ratings> ratings;
  String productName;
  ReviewsScreen({@required this.ratings, this.productName});
  RxBool loading = false.obs;
  @override
  Widget build(BuildContext context) {
    // ReviewScreenController controller = ReviewScreenController(productId: productId);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: const Text('Reviews', style: TextStyle(color: Colors.white,),),
      ),
      body: Obx(
              ()=> loading.value? Center(child: CircularProgressIndicator(),):
            ratings.length == 0 || ratings == null
              ? Center(child: const Text('There is No Review', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),)
              : ListView(
            children: ratings.map((review) =>renderListItem(review)).toList(),
          )
      ),
    );
  }
  Widget renderListItem(Ratings review){
    // String date;
    // if(review.createdAt==null){
    //   date='';
    // }
    // else{
    //   date = review.createdAt.replaceRange(10, review.createdAt.length-1, "");
    // }
    return Container(
      width: double.infinity,
//      height: Get.height*0.,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('${productName}\t', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SmoothStarRating(
                    rating: double.parse(review.rate),
                    size: 15,
                    color: Colors.blue
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Text(review.createdAt, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 10,),
            Text(review.message, style: const TextStyle(fontSize: 16)),
            // const SizedBox(height: 10,),
            // review.photo.length == 0 ? Container() : Container(
            //   width: Get.width*0.4,
            //   height: 120,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: NetworkImage(review.photo),
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            // ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
