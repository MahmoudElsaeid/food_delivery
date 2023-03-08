import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_app_bar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/pages/order/view_order.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';
class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin{

  late TabController _tapController;
  late bool _isLoggedIn;

  @override
  void initState(){
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_isLoggedIn){
      _tapController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My orders',

      ),
      body: Column(
        children: [
          Container(
            width: Dimensions.screenWidth,
            child: TabBar(
              indicatorColor: AppColors.mainColor,
              indicatorWeight: 3,
              labelColor: AppColors.mainColor,
              unselectedLabelColor: Theme.of(context).disabledColor,
              controller: _tapController,
              tabs: [
                Tab(text: 'current'),
                Tab(text: 'history'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tapController,
              children: [
                ViewOrder(isCurrent: true),
                ViewOrder(isCurrent: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
