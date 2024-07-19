import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:your_health_mate/features/remainder/controllers/reminder_controller.dart';
import 'package:your_health_mate/utils/constants/colors.dart';
import 'package:your_health_mate/utils/newTheme/new_text_theme.dart';

import '../models/add_reminder.dart';

class ReminderHome extends StatelessWidget {
  final ReminderController reminderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(

                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: YHMColors.lightPurpleSection,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 40,
                          left: 40,
                          child: Image.asset(
                            'assets/images/smile_scribble.png',
                            width: 50,
                            color: YHMColors.orange,
                          )),
                      Positioned(
                          top: -50,
                          right: 0,
                          child: Image.asset(
                            'assets/images/Vector.png',
                            width: 200,
                            color: YHMColors.orange,
                          )),
                      Positioned(
                        bottom: 65,
                        left: 25,
                        child: Text(
                          'Reminders',
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
                          'You have ${reminderController.reminders.length} reminders',
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
              Obx(() {
                if (reminderController.reminders.isEmpty) {
                  return Text('No reminders yet!');
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: reminderController.reminders.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: YHMColors.grey),
                          ),
                          child: ListTile(
                            leading: Icon(Iconsax.notification5,color: YHMColors.orange,),
                            title: Text(
                              reminderController.reminders[index]['title'],
                              style: NewTextTheme.bold!.copyWith(fontSize: 16),
                            ),
                            subtitle: Text(
                                '${reminderController.reminders[index]['time']}, ${reminderController.reminders[index]['date']} ',
                                style:
                                    NewTextTheme.regular!.copyWith(fontSize: 14)),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: YHMColors.orange,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(AddReminder(),transition: Transition.fade,duration: Duration(milliseconds: 600));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
