import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/splash/splash_screen.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'helper/dependencies.dart' as dep;
import 'helper/notification_helper.dart';

Future<dynamic>myBackgroundMessageHandler(RemoteMessage message) async{
  print('onBackground: ${message.notification?.title}/${message.notification?.body}/'
      '${message.notification?.titleLocKey}');
}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dep.init();

  try{
    if(GetPlatform.isMobile){
      final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  }catch(e){
    if(kDebugMode){
      print(e.toString());
    }
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(
          builder: (_) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Food Delivery',
              //home: SignInPage(),
              //home: SplashScreen(),
              initialRoute: RouteHelper.getSplashScreen(),
              getPages: RouteHelper.routes,
              theme: ThemeData(
                primaryColor: AppColors.mainColor,
                fontFamily: 'Roboto'
              ),
            );
          }
        );
      }
    );
  }
}
