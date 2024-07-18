import 'package:flutter/cupertino.dart';
import 'package:your_health_mate/common/shimmer/YHMShimmerEffect.dart';
import 'package:your_health_mate/utils/helper/helper_functions.dart';

class YHMPersonlizedTreatmentShimmer extends StatelessWidget {
  const YHMPersonlizedTreatmentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YHMShimmerEffect(width: YHMHelperFunctions.screenWidth()/1.5, height: 40),
            const SizedBox(height: 15,),
            YHMShimmerEffect(width: YHMHelperFunctions.screenWidth(), height: 20),
            const SizedBox(height: 8,),
            YHMShimmerEffect(width: YHMHelperFunctions.screenWidth(), height: 20),
            const SizedBox(height: 8,),
            YHMShimmerEffect(width: YHMHelperFunctions.screenWidth(), height: 20),
            const SizedBox(height: 8,),
            YHMShimmerEffect(width: YHMHelperFunctions.screenWidth()/3, height: 20),


            const SizedBox(height: 30,),
            YHMShimmerEffect(width: YHMHelperFunctions.screenWidth()/1.5, height: 40),
            const SizedBox(height: 15,),
            YHMShimmerEffect(width: YHMHelperFunctions.screenWidth(), height: 20),
            const SizedBox(height: 8,),
            YHMShimmerEffect(width: YHMHelperFunctions.screenWidth(), height: 20),
            const SizedBox(height: 8,),
            YHMShimmerEffect(width: YHMHelperFunctions.screenWidth(), height: 20),
            const SizedBox(height: 8,),
            YHMShimmerEffect(width: YHMHelperFunctions.screenWidth()/3, height: 20),

            const SizedBox(height: 30,),
            YHMShimmerEffect(width: YHMHelperFunctions.screenWidth()/1.5, height: 40),
            const SizedBox(height: 15,),
            YHMShimmerEffect(width: YHMHelperFunctions.screenWidth(), height: 20),
            const SizedBox(height: 8,),
            YHMShimmerEffect(width: YHMHelperFunctions.screenWidth(), height: 20),
            const SizedBox(height: 8,),
            YHMShimmerEffect(width: YHMHelperFunctions.screenWidth(), height: 20),
            const SizedBox(height: 8,),
            YHMShimmerEffect(width: YHMHelperFunctions.screenWidth()/3, height: 20),

          ],
        ),
      ),
    );
  }
}
