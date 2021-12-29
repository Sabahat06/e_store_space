import 'package:e_store_space/widgets/my_appbar.dart';
import 'package:e_store_space/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/controller/cart/shop_cart_screen_controller.dart';
import 'package:e_store_space/controller/category_controller.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/statics/static_var.dart';
import 'package:e_store_space/view/product/cart_screen.dart';
import 'package:e_store_space/view/search_screen.dart';
import 'package:e_store_space/widgets/my_category_box.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenTab extends StatelessWidget {

  TextEditingController searchController = TextEditingController();
  BottomBarController bottomBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 210.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset("assets/image/image6.jpg", fit: BoxFit.cover,),
              ),
            ),
            SliverAppBar(
              backgroundColor: Colors.black,
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
                          height: 70,
                          width: 50,
                          color: Colors.green
                        ),
                        Container(
                            width: 300,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
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
                        Icon(Icons.sort_outlined, color: Colors.white,),
                      ]
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: GridView.builder(
                      itemCount: 25,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 1.1
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: MyProduct(),
                        );
                      }
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  MyProduct(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage( "assets/image/image6.jpg",),
                fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.blue,width: 2),
              color: Colors.lightGreen
            ),
            height: 250,
            width: 200,
          ),
          Container(
            height: 55,
            width: 200,
            decoration: const BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left:15.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 10,),
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
    );
  }
}
