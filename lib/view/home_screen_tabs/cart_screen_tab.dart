import 'package:e_store_space/settings/color_palates.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/used_mobile_controller.dart';
import 'package:e_store_space/models/used_mobile_model.dart';
import 'package:e_store_space/view/used_mobiles_request_screen.dart';
import 'package:e_store_space/widgets/my_appbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartScreenTab extends StatelessWidget {
  RxInt quantity = 0.obs;
  @override

  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: const [
            Text('Your Cart'),
            Text('2 Items', style: TextStyle(fontSize: 15, color: Colors.black), ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 25,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: MyProduct(),
                  );
                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 7.0, left: 3, right: 3, top: 3),
            child: GestureDetector(
              child: Container(
                height: 45,
                color: ColorPalette.blue,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('PLACE ORDER', style: TextStyle(color: Colors.white, fontSize: 20),),
                    ),
                    Row(
                      children: [
                        Text("Rs ", style: TextStyle(color: Colors.white, fontSize: 20),),
                        Text("100", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                        SizedBox(width: 7,),
                        Container(width: 2, color: Colors.black54,),
                        SizedBox(width: 7,),
                        Center(
                            child: IconButton(
                              icon: Icon(Icons.arrow_forward_outlined,
                                color: Colors.white,
                              ), iconSize: 30,
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  MyProduct(){
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.red.shade200,
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: Offset(2.0, 2.0),
            )
          ],
        ),
        child: Container(
          height: 110,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 85,
                  width: 85,
                  child: Image.asset("assets/image/image6.jpg")
                ),
                Column(
                  children: [
                    SizedBox(height: 30,),
                    Text('Product Name', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Obx(
                      () => Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              quantity.value--;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue
                              ),
                              child: const Icon(Icons.remove, size: 25, color: Colors.white,),
                            ),
                          ),
                          const SizedBox(width: 7,),
                          Text(quantity.value.toString(), style: const TextStyle(fontSize: 14, color: Colors.black), ),
                          const SizedBox(width: 7,),
                          GestureDetector(
                            onTap: (){
                              quantity.value++;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue
                              ),
                              child: const Icon(Icons.add, size: 25, color: Colors.white,),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Text('Price', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),),
              ],
            ),
          )
        ),
      ),
    );
  }
}
