import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:your_health_mate/utils/constants/colors.dart';
import 'package:your_health_mate/utils/newTheme/new_text_theme.dart';

import '../../../data/service/remainder/background_task.dart';
import '../controllers/reminder_controller.dart';



class AddReminder extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _timesController = TextEditingController();
  final ReminderController reminderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Reminder',style: NewTextTheme.bold,)),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title',prefixIcon: Icon(Iconsax.notification)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description',prefixIcon: Icon(Iconsax.note_2)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date',prefixIcon: Icon(Iconsax.calendar)),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    _dateController.text = pickedDate.toString().split(' ')[0];
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Time',prefixIcon: Icon(Iconsax.timer_1)),
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    _timeController.text = pickedTime.format(context);
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _timesController,
                decoration: InputDecoration(labelText: 'Number of Times in a Day',prefixIcon: Icon(Iconsax.activity)),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,

                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      var reminder = {
                        'title': _titleController.text,
                        'description': _descriptionController.text,
                        'date': _dateController.text,
                        'time': _timeController.text,
                        'times': int.parse(_timesController.text),
                      };
                      reminderController.addReminder(reminder);
                      scheduleBackgroundTask(
                        _titleController.text,
                        _descriptionController.text,
                        _dateController.text,
                        _timeController.text,
                        int.parse(_timesController.text),
                      );
                      Get.back();
                    }
                  },
                  child: Container(child: Text('Add Reminder',style: NewTextTheme.bold!.copyWith(fontSize: 16,color: Colors.white),),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: YHMColors.orange,
                    ),
                    height: 60,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
