import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:iconsax/iconsax.dart';
import 'package:your_health_mate/features/health/screens/personalized_treatment/widgets/animated_text.dart';
import 'package:your_health_mate/features/health/screens/personalized_treatment/widgets/personlized_treatment_shmmer_screen.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/newTheme/new_text_theme.dart';
import '../../../personalization/controller/user_controller.dart';
import '../../controllers/chat/personal_treatment_controller.dart';

class YHMPersonalTreatmanetScreen extends StatelessWidget {
  final PersonalTreatmentController controller = Get.put(PersonalTreatmentController());
  final userController = Get.find<UserController>();
  final dName;
  YHMPersonalTreatmanetScreen({super.key, required this.dName});
  @override
  Widget build(BuildContext context) {
    controller.fetchCommand();
    controller.getDietPlan(dName);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (controller.isLoading.value /**|| controller.paragraph.isEmpty || controller.symptoms.isEmpty || controller.whatToDo.isEmpty || controller.whatNotToDo.isEmpty || controller.graphXValues.isEmpty || controller.graphYValues.isEmpty **/) {
                  return YHMPersonlizedTreatmentShimmer();
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [



                      /// -- top row
                      const SizedBox(height: 50,),
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

                      /// -- graph
                      const SizedBox(height: 20),
                      if (controller.graphXValues.isNotEmpty &&
                          controller.graphYValues.isNotEmpty)
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
                                      ),
                                    ),
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: false,
                                      ),
                                    ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: false,
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        interval: 1,
                                        getTitlesWidget: (value, meta) {
                                          int index = value.toInt();
                                          if (index >= 0 &&
                                              index < controller.graphXValues.length) {
                                            return SideTitleWidget(
                                              fitInside: SideTitleFitInsideData.fromTitleMeta(meta),
                                              axisSide: meta.axisSide,
                                              child: Text(
                                                controller.graphXValues[index],
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
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  gridData: FlGridData(
                                    show: false,
                                  ),
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
                                      dotData: FlDotData(
                                        show: false,
                                      ),
                                      spots: List.generate(
                                        controller.graphYValues.length,
                                            (index) {
                                          return FlSpot(
                                            index.toDouble(),
                                            controller.graphYValues[index],
                                          );
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



                      /// -- basic information
                      const SizedBox(height: 30,),
                      Container(
                        padding: EdgeInsets.only(top: 40,right: 25,left: 25,bottom: 25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color:YHMColors.paragraphBackground
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Basic Information',style: NewTextTheme.bold!.copyWith(fontSize: 22),),

                              ],
                            ),

                            const SizedBox(height: 15,),
                            Text('${controller.paragraph.value}',
                              style: NewTextTheme.regular!.copyWith(fontSize: 16),textAlign: TextAlign.justify,)
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.only(top: 40,right: 25,left: 25,bottom: 25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color:YHMColors.whatToDoBackground
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Symptoms',style: NewTextTheme.bold!.copyWith(fontSize: 22),),

                              ],
                            ),

                            const SizedBox(height: 15,),
                            for (var symptom in controller.symptoms)
                              Row(
                                children: [
                                  Icon(Iconsax.radar_1,size: 20,),
                                  const SizedBox(width: 10,height: 35,),
                                  Expanded(child: Text('$symptom',style :NewTextTheme.regular!.copyWith(fontSize: 16))),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.only(top: 40,right: 25,left: 25,bottom: 25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color:YHMColors.graphBackground
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('What to do?',style: NewTextTheme.bold!.copyWith(fontSize: 22),),

                              ],
                            ),

                            const SizedBox(height: 15,),
                            for (var whatToDo in controller.whatToDo)
                              Row(
                                children: [
                                  Icon(Icons.done,size: 20,),
                                  const SizedBox(width: 10,height: 35,),
                                  Expanded(child: Text('$whatToDo',style :NewTextTheme.regular!.copyWith(fontSize: 16))),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.only(top: 40,right: 25,left: 25,bottom: 25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color:YHMColors.whatNotToDoBackground
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('What not to do?',style: NewTextTheme.bold!.copyWith(fontSize: 22),),

                              ],
                            ),

                            const SizedBox(height: 15,),
                            for (var whatToDo in controller.whatNotToDo)
                              Row(
                                children: [
                                  Icon(Icons.close,size: 20,),
                                  const SizedBox(width: 10,height: 35,),
                                  Expanded(child: Text('$whatToDo',style :NewTextTheme.regular!.copyWith(fontSize: 16))),
                                ],
                              ),
                          ],
                        ),
                      ),



                      const SizedBox(height: 20),
                      Container(width: double.infinity,child: ElevatedButton(onPressed: (){controller.saveRecord();}, child: Text('Save Record')))
                    ],
                  );
                }
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
