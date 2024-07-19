import 'package:flutter/material.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../personalization/screens/setting/widgets/circular_image.dart';

class YHMServiceItemLayout extends StatelessWidget {
  const YHMServiceItemLayout({super.key, required this.img, required this.text});

  final String img;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        YHMCircularImage(image: img,isNetworkImage: true,height: 26,width: 26,radius: 2,padding: 0,backgroundColor: Colors.white,fit: BoxFit.cover,),
        const SizedBox(
          width: YHMSizes.spaceBtwItems,
        ),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 15),
          ),
        ),
        const SizedBox(height: 40,)
      ],
    );
  }
}
