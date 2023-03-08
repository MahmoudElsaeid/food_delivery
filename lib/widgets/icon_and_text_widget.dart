import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final double? size;

  const IconAndTextWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: Dimensions.iconSize24,),
        SizedBox(width: 4,),
        SmallText(text: text,size: Dimensions.font10,),

      ],
    );
  }
}
