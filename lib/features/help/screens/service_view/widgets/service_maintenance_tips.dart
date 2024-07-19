import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/headings/screen_sub_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class YHMServiceMaintenanceTips extends StatelessWidget {
  const YHMServiceMaintenanceTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenSubHeading(title: 'Maintenance Tips'),
        Row(
          children: [
            Icon(
              Icons.check,
            ),
            const SizedBox(
              width: YHMSizes.spaceBtwItems,
            ),
            Flexible(
              child: Text(
                'Service the AC unit at least twice a year.',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: YHMSizes.spaceBtwItems,
        ),
        Row(
          children: [
            Icon(
              Icons.check,
            ),
            const SizedBox(
              width: YHMSizes.spaceBtwItems,
            ),
            Flexible(
              child: Text(
                'Maintain the unit at an ideal operating temperature of 24 °C',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: YHMSizes.spaceBtwItems,
        ),
        Row(
          children: [
            Icon(
              Icons.check,
            ),
            const SizedBox(
              width: YHMSizes.spaceBtwItems,
            ),
            Flexible(
              child: Text(
                'Keep the area around the outdoor unit(condenser) free from debris',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: YHMSizes.spaceBtwItems,
        ),
        Row(
          children: [
            Icon(
              Icons.check,
            ),
            const SizedBox(
              width: YHMSizes.spaceBtwItems,
            ),
            Flexible(
              child: Text(
                'Pay attention to any unusual sounds, smells, or changes in cooling performance',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: YHMSizes.spaceBtwItems,
        ),
        Row(
          children: [
            Icon(
              Icons.close,
            ),
            const SizedBox(
              width: YHMSizes.spaceBtwItems,
            ),
            Flexible(
              child: Text(
                'Avoid opening windows & doors',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: YHMSizes.spaceBtwSections * 5,
        ),
      ],
    );
  }
}
