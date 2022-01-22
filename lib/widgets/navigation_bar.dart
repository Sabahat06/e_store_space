import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/settings/color_palates.dart';


class BottomNavigateBar extends StatelessWidget {
  BottomBarController bottomController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetX<BottomBarController>(
        builder: (controller) {
          return bottomController.isSeller.value
              ?  BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            selectedFontSize: 12.sp,
            unselectedFontSize: 12.sp,
            currentIndex: controller.currentBNBIndex.value,
            onTap: controller.indexChanged,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black54,
            items: const <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notification_add_outlined),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_view_day_outlined),
                label: 'Buyer Request',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity),
                label: 'Account',
              ),
            ],
          )
              : bottomController.isAffiliate.value
                ? BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            selectedFontSize: 12.sp,
            unselectedFontSize: 12.sp,
            currentIndex: controller.currentBNBIndex.value,
            onTap: controller.indexChanged,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black54,
            items: const <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notification_add_outlined),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_view_day_outlined),
                label: 'Buyer Request',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity),
                label: 'Account',
              ),
            ],
          )
                : BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            currentIndex: controller.currentBNBIndex.value,
            onTap: controller.indexChanged,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black54,
            items: const <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity),
                label: 'Account',
              ),
            ],
          );
        }
    );
  }
}