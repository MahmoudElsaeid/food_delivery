import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.44;
  static double pageViewContainer = screenHeight / 3.54;
  static double pageViewTextContainer = screenHeight / 6.5;

  //dynamic height padding and margin
  static double height10 = screenHeight / 78;
  static double height15 = screenHeight / 52;
  static double height20 = screenHeight / 39;
  static double height30 = screenHeight / 26;
  static double height45 = screenHeight / 17.33;

  //dynamic width padding and margin
  static double width10 = screenHeight / 78;
  static double width15 = screenHeight / 52;
  static double width20 = screenHeight / 39;
  static double width30 = screenHeight / 26;
  static double width45 = screenHeight / 17.33;

  //font size
  static double font10 = screenHeight / 78;
  static double font14 = screenHeight / 55.71;
  static double font16 = screenHeight / 48.75;
  static double font20 = screenHeight / 39;
  static double font24 = screenHeight / 32.5;
  static double font26 = screenHeight / 30;
  static double font12 = screenHeight / 65;

  //radius
  static double radius15 = screenHeight / 52;
  static double radius20 = screenHeight / 39;
  static double radius30 = screenHeight / 26;

  //icon size
  static double iconSize24 = screenHeight / 32.5;
  static double iconSize20 = screenHeight / 39;
  static double iconSize16 = screenHeight / 48.75;

  //List view size
  static double listViewImgSize = screenWidth / 3;
  static double listViewTextContSize = screenWidth / 3.6;

  //Popular Food
  static double popularFoodImgSize = screenHeight / 2.22;

  //Bottom Height
  static double bottomHeightBar = screenHeight /6.5;

  //Splash Screen
  static double splashImg = screenHeight /3.12;
}
