import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YHMSymtopsCheker extends StatefulWidget {
  const YHMSymtopsCheker({super.key});

  @override
  _YHMSymtopsChekerState createState() => _YHMSymtopsChekerState();
}

class _YHMSymtopsChekerState extends State<YHMSymtopsCheker> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Checker'),
      ),
    );
  }
}
