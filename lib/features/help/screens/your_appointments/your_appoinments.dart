import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:your_health_mate/common/styles/spacing_style.dart';
import 'package:your_health_mate/utils/constants/colors.dart';

import '../../controllers/service/your_appointments_controller.dart';

class YHMYourAppointments extends StatelessWidget {
  const YHMYourAppointments({super.key});


  @override
  Widget build(BuildContext context) {
    final YourAppointmentsController controller = Get.put(YourAppointmentsController());

    return Scaffold(
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: YHMSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(

                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: YHMColors.primary.withOpacity(0.1),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            top: 40,
                            left: 40,
                            child: Image.asset(
                              'assets/images/smile_scribble.png',
                              width: 50,
                              color: YHMColors.primary,
                            )),
                        Positioned(
                            top: -50,
                            right: 0,
                            child: Image.asset(
                              'assets/images/Vector.png',
                              width: 200,
                              color: YHMColors.primary,
                            )),
                        Positioned(
                          bottom: 65,
                          left: 25,
                          child: Text(
                            'Your Appointments',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: YHMColors.dark,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 40,
                          left: 25,
                          child: Text(
                            'Maintain your record.',
                            style: TextStyle(
                              fontSize: 18,
                              color: YHMColors.dark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Column(
                  children: controller.appointments.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final bookingDate = (data['bookingDate'] as Timestamp).toDate();
                    final formattedDate = DateFormat.yMMMd().format(bookingDate);
                    // Build your UI here using the data from Firestore
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [

                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: data['bookingServiceStatus'].toString().toLowerCase()=='accepted' ? YHMColors.primary.withOpacity(0.1): data['bookingServiceStatus'].toString().toLowerCase()=='requested' ?  YHMColors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                            ),
                            child: data['bookingServiceStatus'].toString().toLowerCase()=='accepted' ? Icon(Icons.done,color: YHMColors.primary,): data['bookingServiceStatus'].toString().toLowerCase()=='requested' ?  Icon(Icons.timer_outlined,color: YHMColors.green,) : Icon(Icons.close,color: YHMColors.orange,),
                          ),
                          const SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data['serviceProviderEmail'] ?? 'No Service Provider'),
                              Text('$formattedDate, ${data['bookingTime']}' ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
