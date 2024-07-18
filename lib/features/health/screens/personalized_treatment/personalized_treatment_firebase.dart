import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/newTheme/new_text_theme.dart';
import '../../../personalization/controller/user_controller.dart';
import '../../models/personlized_treatment/diet_model.dart';

class YHMPersonalizedTreatmentFirebase extends StatefulWidget {
  YHMPersonalizedTreatmentFirebase({
    super.key,
    required this.diseaseName,
    required this.paragraph,
    required this.symptoms,
    required this.whatToDo,
    required this.whatNotToDo,
    required this.graphData,
  });

  final String diseaseName;
  final String paragraph;
  final List<String> symptoms;
  final List<String> whatToDo;
  final List<String> whatNotToDo;
  final GraphData graphData;

  @override
  _YHMPersonalizedTreatmentFirebaseState createState() =>
      _YHMPersonalizedTreatmentFirebaseState();
}

class _YHMPersonalizedTreatmentFirebaseState
    extends State<YHMPersonalizedTreatmentFirebase> {
  final userController = Get.find<UserController>();
  final FlutterTts flutterTts = FlutterTts();
  String? highlightedText;

  Future<void> _speak(String text) async {
    setState(() {
      highlightedText = text;
    });

    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);

    flutterTts.setCompletionHandler(() {
      setState(() {
        highlightedText = null;
      });
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Widget _buildTextSection(String title, String text) {
    return Container(
      padding: const EdgeInsets.only(top: 40, right: 25, left: 25, bottom: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: YHMColors.paragraphBackground),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: NewTextTheme.bold!.copyWith(fontSize: 22),
              ),
              GestureDetector(
                onTap: () => _speak(text),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: YHMColors.dark.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(Iconsax.volume_high),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Text(
            text,
            style: NewTextTheme.regular!.copyWith(
              fontSize: 16,
              backgroundColor: highlightedText == text
                  ? YHMColors.highlight
                  : Colors.transparent,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: ()=>Get.back(),
                    child: Container(
                      width: 55,
                      height: 55,
                      child: Icon(Iconsax.arrow_left),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: YHMColors.dark.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        child: Icon(Iconsax.share),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: YHMColors.dark.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 55,
                        height: 55,
                        child: Icon(Iconsax.like_1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: YHMColors.dark.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              if (widget.graphData.xValues.isNotEmpty &&
                  widget.graphData.yValues.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: YHMColors.primary.withOpacity(0.1),
                  ),
                  padding: const EdgeInsets.only(
                      top: 40, bottom: 30, left: 0, right: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          'Statistics',
                          style: NewTextTheme.bold!.copyWith(fontSize: 22),
                        ),
                      ),
                      Container(
                        height: 240,
                        child: LineChart(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate,
                          LineChartData(
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                  reservedSize: 40,
                                  interval: 1,
                                  getTitlesWidget: (value, meta) {
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Text(
                                        value.toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 1,
                                  getTitlesWidget: (value, meta) {
                                    int index = value.toInt();
                                    if (index >= 0 &&
                                        index < widget.graphData.xValues.length) {
                                      return SideTitleWidget(
                                        fitInside:
                                        SideTitleFitInsideData.fromTitleMeta(
                                            meta),
                                        axisSide: meta.axisSide,
                                        child: Text(
                                          widget.graphData.xValues[index],
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      );
                                    }
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: const Text(''),
                                    );
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                show: true,
                                isCurved: true,
                                color: YHMColors.primary,
                                barWidth: 2,
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: [
                                      YHMColors.primary.withOpacity(0.5),
                                      YHMColors.primary.withOpacity(0.1),
                                      YHMColors.primary.withOpacity(0.0),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                dotData: FlDotData(show: false),
                                spots: List.generate(
                                  widget.graphData.yValues.length,
                                      (index) {
                                    return FlSpot(index.toDouble(),
                                        widget.graphData.yValues[index]);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 30),
              _buildTextSection('Basic Information', widget.paragraph),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.only(
                    top: 40, right: 25, left: 25, bottom: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: YHMColors.whatToDoBackground,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Symptoms',
                          style: NewTextTheme.bold!.copyWith(fontSize: 22),
                        ),
                        GestureDetector(
                          onTap: () => _speak(widget.symptoms.join(', ')),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: YHMColors.dark.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(Iconsax.volume_high),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    for (var symptom in widget.symptoms)
                      Row(
                        children: [
                          const Icon(
                            Iconsax.radar_1,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                            height: 35,
                          ),
                          Expanded(
                            child: Text(
                              symptom,
                              style: NewTextTheme.regular!.copyWith(
                                fontSize: 16,
                                backgroundColor: highlightedText == symptom
                                    ? YHMColors.highlight
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.only(
                    top: 40, right: 25, left: 25, bottom: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: YHMColors.graphBackground,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'What to do?',
                          style: NewTextTheme.bold!.copyWith(fontSize: 22),
                        ),
                        GestureDetector(
                          onTap: () => _speak(widget.whatToDo.join(', ')),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: YHMColors.dark.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(Iconsax.volume_high),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    for (var whatToDo in widget.whatToDo)
                      Row(
                        children: [
                          const Icon(
                            Icons.done,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                            height: 35,
                          ),
                          Expanded(
                            child: Text(
                              whatToDo,
                              style: NewTextTheme.regular!.copyWith(
                                fontSize: 16,
                                backgroundColor: highlightedText == whatToDo
                                    ? YHMColors.highlight
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.only(
                    top: 40, right: 25, left: 25, bottom: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: YHMColors.whatNotToDoBackground,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'What not to do?',
                          style: NewTextTheme.bold!.copyWith(fontSize: 22),
                        ),
                        GestureDetector(
                          onTap: () => _speak(widget.whatNotToDo.join(', ')),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: YHMColors.dark.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(Iconsax.volume_high),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    for (var whatNotToDo in widget.whatNotToDo)
                      Row(
                        children: [
                          const Icon(
                            Icons.close,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                            height: 35,
                          ),
                          Expanded(
                            child: Text(
                              whatNotToDo,
                              style: NewTextTheme.regular!.copyWith(
                                fontSize: 16,
                                backgroundColor: highlightedText == whatNotToDo
                                    ? YHMColors.highlight
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
