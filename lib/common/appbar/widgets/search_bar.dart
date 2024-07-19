import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helper/helper_functions.dart';


class YHMSearchBar extends StatelessWidget{

  const YHMSearchBar({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      width: YHMHelperFunctions.screenWidth(),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(100),

        boxShadow: [
          BoxShadow(blurStyle: BlurStyle.outer,
              color: YHMColors.dark.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 0),
              spreadRadius: -2)
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.search_rounded,
            size: YHMSizes.iconMd + 5,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Which Service?',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(
                        height: 1.3,
                        fontWeight: FontWeight.w600)),
                Flexible(
                    child: Text(
                        'Any Service • Any Where • Any Time',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium)),
              ],
            ),
          )
        ],
      ),
    );
  }

}