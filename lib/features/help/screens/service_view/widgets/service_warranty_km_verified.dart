import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';

class YHMServiceWarrantyKmVerified extends StatelessWidget {
  const YHMServiceWarrantyKmVerified({super.key, required this.liveServiceWarraunty, required this.kms});

  final String liveServiceWarraunty;
  final String kms;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: YHMColors.grey.withOpacity(0.8)),
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          if(liveServiceWarraunty!='No Warranty')
            Column(children: [
              Icon(
                Iconsax.shield_tick,
                size: 26,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.2,fontSize: 13),
              ),
            ]),
          if(liveServiceWarraunty!='No Warranty')
            Container(
              width: 1,
              height: 70,
              color: YHMColors.grey.withOpacity(0.8),
            ),

          Column(children: [
            Icon(
              Iconsax.routing,
              size: 26,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${kms}\n kms away',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.2,fontSize: 13),
            ),
          ]),
          Container(
            width: 1,
            height: 70,
            color: YHMColors.grey.withOpacity(0.8),
          ),

          Column(children: [
            Icon(
              Iconsax.verify,
              size: 26,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'YHM Verified \n Doctor',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.2,fontSize: 13),
            ),
          ]),
        ],
      ),
    );
  }
}
