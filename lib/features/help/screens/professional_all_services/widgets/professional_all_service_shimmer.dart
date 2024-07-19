import 'package:flutter/cupertino.dart';

import '../../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../../common/styles/spacing_style.dart';


class YHMProfessionalAllServiceShimmer extends StatelessWidget {
  const YHMProfessionalAllServiceShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: YHMSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70,),
            YHMShimmerEffect(width: double.infinity, height: 60,radius: 8,),
            const SizedBox(height: 20,),
            YHMShimmerEffect(width: 200, height: 30,radius: 8,),
            const SizedBox(height: 20,),
            YHMShimmerEffect(width: double.infinity, height: 90,radius: 8,),
            const SizedBox(height: 20,),
            YHMShimmerEffect(width: double.infinity, height: 90,radius: 8,),
            const SizedBox(height: 20,),
            YHMShimmerEffect(width: double.infinity, height: 90,radius: 8,),
            const SizedBox(height: 20,),
            YHMShimmerEffect(width: double.infinity, height: 90,radius: 8,),
            const SizedBox(height: 20,),
            YHMShimmerEffect(width: double.infinity, height: 90,radius: 8,),


          ],
        ),
      ),
    );
  }
}
