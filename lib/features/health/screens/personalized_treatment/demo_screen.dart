import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:your_health_mate/common/widgets/Dividers/divider_line.dart';
import 'package:your_health_mate/features/health/screens/personalized_treatment/widgets/animated_text.dart';
import 'package:your_health_mate/features/personalization/controller/user_controller.dart';
import 'package:your_health_mate/utils/constants/colors.dart';
import 'package:your_health_mate/utils/newTheme/new_text_theme.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class DemoScreen extends StatelessWidget {
  DemoScreen({super.key});

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Relax, ',style: NewTextTheme.bold!.copyWith(fontSize: 20,color: YHMColors.dark.withOpacity(0.9))),
                AnimatedGradientText(text: '${userController.user.value.fullName},', style: NewTextTheme.bold!.copyWith(fontSize: 20))
              ],),
              Text(
                 'We have disease info.',
                style: NewTextTheme.bold!.copyWith(fontSize: 20),
              ),
        
              const SizedBox(height: 30,),
              Container(
        
                padding: EdgeInsets.only(top: 40,right: 25,left: 25,bottom: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color:YHMColors.paragraphBackground
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Basic Information',style: NewTextTheme.bold!.copyWith(fontSize: 20),),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: YHMColors.dark.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: Icon(Iconsax.volume_high),
                        )
                      ],
                    ),
        
        
                    const SizedBox(height: 15,),
                    Text('Diabetes is a chronic condition that affects how your body regulates blood sugar. In healthy people, the hormone insulin helps move sugar from your bloodstream into your cells for energy. With diabetes, either your body doesnt produce enough insulin or your cells become resistant to it. This can lead IO high blood Sugar levels, which over lime Can damage your organs and tissues.',
                      style: NewTextTheme.regular!.copyWith(fontSize: 16),textAlign: TextAlign.justify,)
                  ],
                ),
              ),
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
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: YHMColors.dark.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Icon(Iconsax.volume_high),
                        )
                      ],
                    ),

                    const SizedBox(height: 15,),
                    for (int i = 1 ; i<10 ; i++)
                      Row(
                        children: [
                          Icon(Icons.close,size: 20,),
                          const SizedBox(width: 10,height: 35,),
                          Expanded(child: Text('what is the main issue about the development is you dont know responsive ness is very impotant part of the ui desiging that is very main component',style :NewTextTheme.regular!.copyWith(fontSize: 16))),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


