import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_health_mate/common/styles/spacing_style.dart';
import 'package:your_health_mate/features/college_project/screen/encypted_chat_screen.dart';
import 'package:your_health_mate/features/myonsitehealthcare/screens/input_screen/widgets/appointment_form.dart';
import 'package:your_health_mate/features/myonsitehealthcare/screens/input_screen/widgets/top_text.dart';
import '../../../../utils/constants/sizes.dart';

class IPInputScreen extends StatelessWidget {
  const IPInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
      body: Padding(
        padding: YHMSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // - top text
            IPTopText(),
            SizedBox(height: YHMSizes.spaceBtwInputFields),

            // -- form for appointment code with button
            IPAppointmentForm(),


          ],
        ),
      ),
    );
  }
}
