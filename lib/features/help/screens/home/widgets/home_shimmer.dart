import 'package:flutter/material.dart';

import '../../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../../utils/constants/sizes.dart';


class HomeScreenShimmerEffect extends StatelessWidget {
  const HomeScreenShimmerEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          YHMShimmerEffect(width: 100, height: 20),
          SizedBox(height: 10,),
          YHMShimmerEffect(width: 200, height: 20),
          SizedBox(height: YHMSizes.spaceBtwSections,),
          YHMShimmerEffect(width: 100, height: 30),
          SizedBox(height: 10,),
          YHMShimmerEffect(width: MediaQuery.of(context).size.width, height: 30),
        ],
      ),
    );
  }
}