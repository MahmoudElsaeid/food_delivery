import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';

class AppColumnDetail extends StatelessWidget {
  final String text;

  const AppColumnDetail({
    Key? key,
    required this.text,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        BigText(text: text, size: Dimensions.font20,),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Wrap(
              children: List.generate(5, (index) => const Icon(
                Icons.star,
                color: AppColors.mainColor,
                size: 15,
              )),
            ),
             SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(text: "4.5"),
             SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(text: "1287"),
             SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(text: "Comments"),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconAndTextWidget(
              icon: Icons.circle_rounded,
              text: "Normal",
              iconColor: AppColors.iconColor1,
            ),
            IconAndTextWidget(
              icon: Icons.location_on,
              text: "1.7km",
              iconColor: AppColors.mainColor,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: "32 min",
              iconColor: AppColors.iconColor2,
            ),
          ],
        ),
      ],
    );
  }
}
