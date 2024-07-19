import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../../common/widgets/headings/screen_sub_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';

class YHMServiceHowWeWork extends StatelessWidget {
  const YHMServiceHowWeWork({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenSubHeading(title: 'How we work?',size: 20),
        //implement time line to show steps how we
        TimelineTile(
          beforeLineStyle:
          const LineStyle(color: YHMColors.grey, thickness: 1.5),
          afterLineStyle:
          const LineStyle(color: YHMColors.grey, thickness: 1.5),
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          isFirst: true,
          indicatorStyle: const IndicatorStyle(
              width: 20,
              color: YHMColors.primary,
              padding: EdgeInsets.only(right: 10)),
          endChild: Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(
                  top: 13, left: 20, right: 20, bottom: 13),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: YHMColors.grey.withOpacity(0.8))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Book a Slot',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Select a convenient time slot for your appointment from the available options in the app.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Center(
                      child: Image.asset(
                        YHMImages.onBoardingImage1,
                        height: 180,
                      )),
                ],
              )),
        ),
        TimelineTile(
          beforeLineStyle:
          const LineStyle(color: YHMColors.grey, thickness: 1.5),
          afterLineStyle:
          const LineStyle(color: YHMColors.grey, thickness: 1.5),
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          indicatorStyle: const IndicatorStyle(
              width: 20,
              color: YHMColors.primary,
              padding: EdgeInsets.only(right: 10)),
          endChild: Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(
                  top: 13, left: 20, right: 20, bottom: 13),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: YHMColors.grey.withOpacity(0.8))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Doctor Confirmation',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'The doctor will review your request and either accept the appointment or suggest an alternative time if the chosen slot is unavailable.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Center(
                      child: Image.asset(
                        YHMImages.onBoardingImage3,
                        height: 180,
                      )),
                ],
              )),
        ),
        TimelineTile(
          isLast: true,
          beforeLineStyle:
          const LineStyle(color: YHMColors.grey, thickness: 1.5),
          afterLineStyle:
          const LineStyle(color: YHMColors.grey, thickness: 1.5),
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          indicatorStyle: const IndicatorStyle(
              width: 20,
              color: YHMColors.primary,
              padding: EdgeInsets.only(right: 10)),
          endChild: Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(
                  top: 13, left: 20, right: 20, bottom: 13),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: YHMColors.grey.withOpacity(0.8))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Visit Help Center',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Once your appointment is confirmed, visit the designated help center at the scheduled time for your consultation.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Center(
                      child: Image.asset(
                        YHMImages.onBoardingImage2,
                        height: 180,
                      )),
                ],
              )),
        ),
      ],
    );
  }
}
