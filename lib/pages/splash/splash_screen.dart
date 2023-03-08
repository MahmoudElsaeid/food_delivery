import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().updateToken();
    _loadResource();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2))..forward();

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );

    Timer(
      Duration(seconds: 3),
      ()=>Get.offNamed(RouteHelper.getInitial()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image.asset(
                    'assets/image/logo part 1.jpg',
                    width: Dimensions.splashImg,
                  ),
              ),
          ),
        /*  Center(
              child: Image.asset(
                'assets/image/logo part 2.png',
                width: Dimensions.splashImg,
              ),
          ),*/
        ],
      ),
    );
  }
}
