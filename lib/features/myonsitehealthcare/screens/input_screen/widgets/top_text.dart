import 'package:flutter/material.dart';

class IPTopText extends StatelessWidget {
  const IPTopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hey There !',style: Theme.of(context).textTheme.titleLarge,),
        Text('Enter your Appointment Code for check status',style: Theme.of(context).textTheme.bodySmall,),
      ],
    );
  }
}
