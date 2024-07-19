import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../../utils/helper/helper_functions.dart';


class YHMServiceViewServiceImage extends StatelessWidget {
  const YHMServiceViewServiceImage({super.key,required this.liveServiceImg});
  final String liveServiceImg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: YHMHelperFunctions.screenWidth() / 1.15,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: liveServiceImg,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: YHMShimmerEffect(
              width: 195,
              height: 195,
            ),
          ),
          errorWidget: (context, url, error) =>
          const Icon(Icons.error),
        ),
      ),
    );
  }
}
