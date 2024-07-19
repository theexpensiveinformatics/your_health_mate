import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import '../../../../../common/shimmer/YHMShimmerEffect.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helper/helper_functions.dart';

class ServiceCard extends StatefulWidget {
  const ServiceCard({
    Key? key,
    required this.liveServiceId,
    required this.imageUrl,
    required this.serviceName,
    required this.warranty,
    required this.cost,
    required this.category, required this.serviceId, required this.professionalId,
  }) : super(key: key);

  final String liveServiceId;
  final String imageUrl;
  final String serviceName;
  final String warranty;
  final String cost;
  final String category;
  final String serviceId;
  final String professionalId;

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        // Get.to(() => YHMServiceInformationScreen(
        //   serviceId: widget.serviceId,
        //   professionalId: widget.professionalId,
        //   liveServiceId: widget.liveServiceId,
        //   imageUrl: widget.imageUrl,
        //   serviceName: widget.serviceName,
        //   warranty: widget.warranty,
        //   cost: widget.cost,
        //   category: widget.category,
        // ));
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: Duration(milliseconds: 100),
        child: Padding(
          padding: const EdgeInsets.only(bottom: YHMSizes.md),
          child: Container(
            height: 80,
            padding: EdgeInsets.all(YHMSizes.sm),
            width: double.infinity,
            decoration: BoxDecoration(
              color: YHMHelperFunctions.isDarkMode(context)
                  ? YHMColors.black
                  : YHMColors.white,
              boxShadow: [
                BoxShadow(
                  color: YHMHelperFunctions.isDarkMode(context)
                      ? Colors.black26
                      : YHMColors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: YHMHelperFunctions.isDarkMode(context)
                      ? YHMColors.grey.withOpacity(0.1)
                      : YHMColors.grey.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 80,
                    height: 70,
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      fit: BoxFit.scaleDown,
                      placeholder: (context, url) => const Center(
                        child: YHMShimmerEffect(
                          width: 195,
                          height: 195,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                const SizedBox(
                  width: YHMSizes.spaceBtwItems,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        '${widget.serviceName}',
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Iconsax.shield_tick,
                          size: YHMSizes.iconSm,
                        ),
                        const SizedBox(
                          width: YHMSizes.spaceBtwItems / 2,
                        ),
                        Container(
                            width: YHMHelperFunctions.screenWidth() / 3.5,
                            child: Text(
                              '${widget.warranty}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
                  decoration: BoxDecoration(
                    color: YHMColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '₹ ${widget.cost}',
                    style: TextStyle(
                        color: YHMColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
