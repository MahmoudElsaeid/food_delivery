import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimensions.height20*3,
        width: Dimensions.height20*3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius30+Dimensions.radius20),
          color: AppColors.mainColor,
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
