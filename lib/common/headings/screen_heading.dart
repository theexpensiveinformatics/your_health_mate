import 'package:flutter/material.dart';

class YHMScreenHeading extends StatelessWidget {
  const YHMScreenHeading({
    super.key, required this.title,this.textSize = 26

  });

  final String title;
  final double textSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize:textSize ),
    );
  }
}