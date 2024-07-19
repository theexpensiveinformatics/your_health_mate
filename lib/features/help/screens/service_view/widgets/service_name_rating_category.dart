import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../utils/constants/sizes.dart';

class YHMServiceViewNameRatingCategory extends StatelessWidget{
  const YHMServiceViewNameRatingCategory({super.key,required this.liveServiceName, required this.rating, required this.liveServiceCategory});


  final String liveServiceName;
  final String liveServiceCategory;
  final String rating;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${liveServiceName}',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: YHMSizes.spaceBtwItems /3,
        ),

        /// -- Rating and Category
        Row(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: YHMSizes.iconSm,
            ),

            Text(
              ' ${rating=='0' ? rating : 'New'} ',style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text('• ${liveServiceCategory} ',style: Theme.of(context).textTheme.bodyMedium,),

          ],
        ),
        const SizedBox(
          height: YHMSizes.defaultSpace,
        ),
      ],
    );
  }

}