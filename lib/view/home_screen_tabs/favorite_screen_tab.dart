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

class FavoriteScreenTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Container(
        child: Center(child: Text('Favorite Tab'),),
      ),
    );
  }

}
