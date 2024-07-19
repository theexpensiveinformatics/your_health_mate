import 'package:flutter/cupertino.dart';


import '../../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../../common/styles/spacing_style.dart';

class YHMServiceShimmmer extends StatelessWidget {
  const YHMServiceShimmmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: YHMSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                YHMShimmerEffect(width: 50, height: 50,radius: 1000,),
                Row(
                  children: [
                    YHMShimmerEffect(width: 50, height: 50,radius: 1000,),
                    const SizedBox(width: 10,),
                    YHMShimmerEffect(width: 50, height: 50,radius: 1000,),
                  ],
                )
              ],
            ),
      
            const SizedBox(height: 30,),
            YHMShimmerEffect(width: double.infinity, height: 400),
            const SizedBox(height: 30,),
            YHMShimmerEffect(width: 300, height: 30,radius: 5,),
            const SizedBox(height: 10,),
            Row(
              children: [
                YHMShimmerEffect(width: 80, height: 20,radius: 5,),
                const SizedBox(width: 10,),
                YHMShimmerEffect(width: 100, height: 20,radius: 5,),
              ],
            ),

            const SizedBox(height: 30,),
            YHMShimmerEffect(width: double.infinity, height: 80,radius: 5,),

            const SizedBox(height: 30,),
            YHMShimmerEffect(width: 300, height: 30,radius: 5,),
            const SizedBox(height: 10,),
            Row(
              children: [
                YHMShimmerEffect(width: 30, height: 20,radius: 5,),
                const SizedBox(width: 10,),
                YHMShimmerEffect(width: 80, height: 20,radius: 5,),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                YHMShimmerEffect(width: 30, height: 20,radius: 5,),
                const SizedBox(width: 10,),
                YHMShimmerEffect(width: 80, height: 20,radius: 5,),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                YHMShimmerEffect(width: 30, height: 20,radius: 5,),
                const SizedBox(width: 10,),
                YHMShimmerEffect(width: 80, height: 20,radius: 5,),
              ],
            ),

            const SizedBox(height: 30,),
            YHMShimmerEffect(width: double.infinity, height: 80,radius: 5,),

            const SizedBox(height: 30,),
            YHMShimmerEffect(width: 300, height: 30,radius: 5,),
            const SizedBox(height: 10,),
            Row(
              children: [
                YHMShimmerEffect(width: 30, height: 20,radius: 5,),
                const SizedBox(width: 10,),
                YHMShimmerEffect(width: 80, height: 20,radius: 5,),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                YHMShimmerEffect(width: 30, height: 20,radius: 5,),
                const SizedBox(width: 10,),
                YHMShimmerEffect(width: 80, height: 20,radius: 5,),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                YHMShimmerEffect(width: 30, height: 20,radius: 5,),
                const SizedBox(width: 10,),
                YHMShimmerEffect(width: 80, height: 20,radius: 5,),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
