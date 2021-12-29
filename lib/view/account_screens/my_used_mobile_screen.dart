import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/used_mobile_controller.dart';
import 'package:e_store_space/models/used_mobile_model.dart';
import 'package:e_store_space/view/homepage.dart';
import 'package:e_store_space/view/used_mobiles_request_screen.dart';
import 'package:e_store_space/widgets/AlertDialogeWidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyUsedMobileScreen extends StatelessWidget {

  MyUsedMobileScreen({Key key}) : super(key: key);
  AuthController authController=Get.find();
  String customerId;
  UsedMobileController usedMobileController;
  RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    usedMobileController=UsedMobileController(authController.user.value.id);
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.off(() => HomePage());}, color: Colors.black,),
        leadingWidth: 30,
        title: const Text('My Devices', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
        () => usedMobileController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            :  usedMobileController.usedMobile.value.products.length == 0
              ? const Center(child: Text('You have not added any mobile yet'),)
              : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Text('user id ${authController.user.value.id}'),
                  SizedBox(width: width, height: 10,),
                  Container(
                    height: Get.height * 0.81,
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Obx(
                        () => SmartRefresher(
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
                            }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton:authController.user.value != null? Container(
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
                child: const Text(
                  'Add new Device',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ))
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
            padding: const EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 20),
            child: Container(
              height: width * 0.69,
              // width: width*0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
                // border: Border.all(color: Colors.orange),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:const EdgeInsets.only(left: 10, top: 2),
                            child: Text(
                              mobiles.mobileName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding:const EdgeInsets.only(left: 10, top: 2,right: 10),
                            child: Text(
                              mobiles.price,
                              style:  TextStyle(fontWeight: FontWeight.normal, fontSize: 20,),),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 2),
                            child: Text(
                              mobiles.customerName,
                              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 2,right: 10),
                            child: Text(
                              mobiles.customerPhone,
                              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),

            ),
          ),
          Positioned(
            right: 0,
            child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(25)),
                child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialogWidget(
                              title: 'Alert',
                              subTitle: "Are you sure to delete mobile details?",
                              onPositiveClick: () {
                                usedMobileController.isLoading.value=true;
                                usedMobileController.deleteMyMobile(mobiles.id);
                                usedMobileController.isLoading.value=false;
                                print('Deleted mobile id = ${mobiles.id}');
                               Get.back();
                              },
                            );
                          }
                      );
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      size: 35,
                      color: Colors.black,
                    ))),
          ),
        ],
      ),
    );
  }


}
