import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/used_mobile_controller.dart';
import 'package:e_store_space/models/used_mobile_model.dart';
import 'package:e_store_space/view/used_mobiles_request_screen.dart';
import 'package:e_store_space/widgets/my_appbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsedMobileScreenTab extends StatelessWidget {
  UsedMobileScreenTab({Key key}) : super(key: key);
  AuthController authController=Get.find();
  UsedMobileController usedMobileController=UsedMobileController('0');
  RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      appBar: MyAppBarWidgets(title: 'All Used Devices').getMyAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: width, height: 10,),
          Container(
            height: Get.height * 0.775,
            width: width * 0.95,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Obx(
                ()=>
                  SmartRefresher(
                    enablePullUp: usedMobileController.search.value?
                    !(usedMobileController.usedMobile.value.totalPages==usedMobileController.currentSearchPage.value):
                    !(usedMobileController.usedMobile.value.totalPages==usedMobileController.currentPage.value),
                    controller: _refreshController,
                    onRefresh: (){
                      usedMobileController.LoadAllUsedMobiles(loadMore: false).then((value)  {
                        _refreshController.refreshCompleted();
                      });
                    },
                    onLoading: (){
                      usedMobileController.LoadAllUsedMobiles(loadMore: true).then((value) {_refreshController.loadComplete();});
                    },
                    child: ListView.builder(
                    itemCount: usedMobileController.usedMobile.value.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return renderSubCategoryItem(context,usedMobileController.usedMobile.value.products[index]);
                    }
                  ),
                )
              ),
            ),
          ),
        ],
      ),
      floatingActionButton:authController.user.value != null
        ? Container(
            child: SizedBox(
            height: 40,
            child: Container(
              child: RaisedButton(
                color: Colors.orange,
                elevation: 20,
                onPressed: (){
                  Get.to(UsedMobileRequestScreen());
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Text('Post a Device', style: TextStyle(color: Colors.white, fontSize: 18),),
                ),
              ),
            )
          )
        : Container(),
    );
  }

  Widget renderSubCategoryItem(BuildContext  context, UsedProducts mobiles) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      // onTap: (){Get.to(()=>ProductScreen(model.id,1,model.title));},
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8,right: 12,left: 12,bottom: 20),
            child: Container(
              // height: width * 0.8,
              width: width*0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
                // border: Border.all(color: Colors.orange),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300],
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(1, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: width * 0.5,
                      width: width,
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                          ),
                          color: Colors.white,
                          image: DecorationImage(
                              image: NetworkImage(mobiles.mobilePhoto),
                              fit: BoxFit.cover)),
                      // child: Row(
                      //   mainAxisSize: MainAxisSize.max,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //    Image.asset('assets/image/usedmob.jpg',fit: BoxFit.cover,)
                      //   ],
                      // )
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 2),
                        child: Text(
                          // 'mobiles.mobileNamesfaasfafafsdafasfasdfafsdfsfssdfsdfsdfsdfsdf',
                          mobiles.mobileName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12,bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 2),
                              child: Text(
                                'Rs.'+ mobiles.price,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal, fontSize: 17),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 2,right: 10),
                              child: Text(
                                mobiles.customerPhone,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal, fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    )
                  ],
                ),

            ),
          ),
          // Positioned(
          //   right: 0,
          //   child: Container(
          //       width: 50,
          //       height: 50,
          //       decoration: BoxDecoration(
          //           color: Colors.orange,
          //           borderRadius: BorderRadius.circular(25)),
          //       child: IconButton(
          //           onPressed: () {
          //             showDialog(
          //                 context: context,
          //                 builder: (BuildContext context) {
          //                   return AlertDialogWidget(
          //                     title: 'Alert',
          //                     subTitle: "Are you sure to delete mobile details?",
          //                     onPositiveClick: () {
          //                       Get.back();
          //                     },
          //                   );
          //                 }
          //             );
          //           },
          //           icon: const Icon(
          //             Icons.delete_outline,
          //             size: 35,
          //             color: Colors.black,
          //           ))),
          // ),
        ],
      ),
    );
  }
  

}
