import 'package:flutter/cupertino.dart';


import '../../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../../utils/helper/helper_functions.dart';

class CategoryShimmerEffect extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20,),
        YHMShimmerEffect(width: YHMHelperFunctions.screenWidth()-100, height: 40,radius: 10,),
        const SizedBox(height: 20,),
        YHMShimmerEffect(width: YHMHelperFunctions.screenWidth()-100, height: 40,radius: 10,),
        const SizedBox(height: 20,),
        YHMShimmerEffect(width: YHMHelperFunctions.screenWidth()-100, height: 40,radius: 10,),
        const SizedBox(height: 20,),
        YHMShimmerEffect(width: YHMHelperFunctions.screenWidth()-100, height: 40,radius: 10,),
        const SizedBox(height: 20,),
        YHMShimmerEffect(width: YHMHelperFunctions.screenWidth()-100, height: 40,radius: 10,),
        const SizedBox(height: 20,),
      ],
    );
  }

}