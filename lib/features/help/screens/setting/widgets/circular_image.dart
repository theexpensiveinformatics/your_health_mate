import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helper/helper_functions.dart';

class YHMCircularImage extends StatelessWidget {

  const YHMCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.backgroundColor,
    this.overlayColor,
    this.padding = YHMSizes.sm,
    this.radius = 1000,

});
  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? backgroundColor;
  final Color? overlayColor;
  final double width, height, padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (YHMHelperFunctions.isDarkMode(context) ? YHMColors.black : YHMColors.white),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
        child: isNetworkImage ? ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: CachedNetworkImage(
            height: height,
            width: width,
            fit: fit,
            imageUrl: image,
            color: overlayColor,
            progressIndicatorBuilder: (context, url, downloadProgress) => const YHMShimmerEffect(width: 56, height: 56,radius: 1000,),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ) : ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image(
            fit: fit,
            image: AssetImage(image) ,
            color: overlayColor,
          ),
        )
      ),
    );
  }
}
