import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:your_health_mate/common/shimmer/YHMShimmerEffect.dart';
import 'package:your_health_mate/common/shimmer/YHMShimmerTreatment.dart';
import 'package:your_health_mate/features/health/controllers/home/home_controller.dart';
import 'package:your_health_mate/features/health/screens/chat/all_chat_list.dart';
import 'package:your_health_mate/features/health/screens/chat/chat_two.dart';
import 'package:your_health_mate/features/health/screens/chat/new_chat.dart';
import 'package:your_health_mate/features/health/screens/home/wigets/emoji_container.dart';
import 'package:your_health_mate/features/health/screens/home/wigets/treatment_item_layout.dart';
import 'package:your_health_mate/features/health/screens/personalized_treatment/personalized_treatment_firebase.dart';
import 'package:your_health_mate/utils/constants/colors.dart';
import 'package:your_health_mate/utils/helper/helper_functions.dart';
import 'package:your_health_mate/utils/newTheme/new_text_theme.dart';
import '../../../help/screens/home/home_three.dart';
import '../../../personalization/controller/user_controller.dart';
import '../../../remainder/screens/reminder_home.dart';

class YHMHomeScreen extends StatelessWidget {
  YHMHomeScreen({super.key});

  final userController = Get.put(UserController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: YHMColors.newLightBlue,
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- top row
                  const SizedBox(
                    height: 45,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/ai_star.png',
                          height: 30,
                          width: 30,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: YHMColors.newDarkBlue,
                          ),
                          child: Icon(
                            Iconsax.settings,
                            size: 25,
                          ),
                        )
                      ],
                    ),
                  ),

                  /// -- I am ai
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'I\'m Bujji AI',
                      style: NewTextTheme.medium!.copyWith(
                          fontSize: 14, color: YHMColors.dark.withOpacity(0.5)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  /// -- rich text
                  Obx(
                    () => userController.profileLoading == true
                        ? YHMShimmerEffect(width: 30, height: 20)
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'Hello, ${userController.user.value.firstName} \nHow do you feel \nabout your ',
                                style: NewTextTheme.medium.copyWith(
                                  fontSize: 28,
                                  height: 1.3,
                                  color: YHMColors.dark,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'current \nemotions?',
                                    style: NewTextTheme.black.copyWith(
                                      fontSize: 28,
                                      color: YHMColors.dark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),



                  /// -- Button
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(YHMAllChatList(),transition: Transition.fade,duration: Duration(milliseconds: 600));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 60,
                        width: YHMHelperFunctions.screenWidth(),
                        decoration: BoxDecoration(
                            color: YHMColors.newDarkBlue,
                            borderRadius: BorderRadius.circular(100)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Start Chatting',
                                style: NewTextTheme.medium.copyWith(
                                    fontSize: 16,
                                    color: YHMColors.newSecondaryBlue),
                              ),
                              Icon(
                                Iconsax.arrow_right_1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                ],
              ),
            ),

            /// -- daily mood log
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daily Mood log',
                    style: NewTextTheme.axiformaBold,
                  ),
                  Icon(
                    Iconsax.more4,
                    size: 18,
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                YHMEmojiContainer(img: 'assets/images/Hello.png'),
                YHMEmojiContainer(img: 'assets/images/Laugh.png'),
                YHMEmojiContainer(img: 'assets/images/Bored.png'),
                YHMEmojiContainer(img: 'assets/images/Pain.png'),
                YHMEmojiContainer(img: 'assets/images/Birthday.png'),
              ],
            ),

            /// other section
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15,left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: ()=>Get.to(YHMServiceHomeScreen()),
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:YHMColors.sectionBookYourSlot.withOpacity(0.5)
                        ),
                        child: Stack(
                          children: [

                            Positioned(
                                bottom: 20,
                                right: 25,
                                child:Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: YHMColors.dark.withOpacity(0.1),
                                  ),
                                  child: Icon(Icons.navigate_next,color: YHMColors.dark.withOpacity(0.8),),
                                ) ),
                            Positioned(child: Opacity(opacity: 0.5,
                                child: Image.asset('assets/images/plane_scribble.png',)),bottom: -80,right: 0,left: -100,),
                            Padding(
                              padding: const EdgeInsets.only(left: 20,top: 20),
                              child: Text('Book your\nSlot',style: NewTextTheme.bold!.copyWith(fontSize: 15),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color:YHMColors.sectionActivity.withOpacity(0.5)
                      ),
                      child: Stack(
                        children: [

                          Positioned(
                            bottom: 20,
                              right: 25,
                              child:Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: YHMColors.dark.withOpacity(0.1),
                                ),
                                child: Icon(Icons.navigate_next,color: YHMColors.dark.withOpacity(0.8),),
                              ) ),
                          Positioned(child: Opacity(opacity: 0.5,
                          child: Image.asset('assets/images/circle_scribble.png',)),bottom: -150,right: 0,left: -150,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 20),
                            child: Text('Activity \nTracker',style: NewTextTheme.bold!.copyWith(fontSize: 15),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15,left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){Get.to(ReminderHome(),transition: Transition.fade,duration: Duration(milliseconds: 600));},
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:YHMColors.sectionRemainder.withOpacity(0.5)
                        ),
                        child: Stack(
                          children: [

                            Positioned(
                                bottom: 20,
                                right: 25,
                                child:Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: YHMColors.dark.withOpacity(0.1),
                                  ),
                                  child: Icon(Icons.navigate_next,color: YHMColors.dark.withOpacity(0.8),),
                                ) ),
                            Positioned(child: Opacity(opacity: 0.5,
                                child: Image.asset('assets/images/smile_scribble.png',)),bottom: -80,right: 0,left: -100,),
                            Padding(
                              padding: const EdgeInsets.only(left: 20,top: 20),
                              child: Text('Set\nRemainder',style: NewTextTheme.bold!.copyWith(fontSize: 15),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color:YHMColors.sectionSymtomsChecker.withOpacity(0.5)
                      ),
                      child: Stack(
                        children: [

                          Positioned(
                              bottom: 20,
                              right: 25,
                              child:Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: YHMColors.dark.withOpacity(0.1),
                                ),
                                child: Icon(Icons.navigate_next,color: YHMColors.dark.withOpacity(0.8),),
                              ) ),
                          Positioned(child: Opacity(opacity: 0.5,
                              child: Image.asset('assets/images/dna_scribble.png',)),bottom: -200,right: 0,left: -90,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 20),
                            child: Text('Symptoms \nchecker',style: NewTextTheme.bold!.copyWith(fontSize: 15),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// -- logs
            const SizedBox(
              height: 10,
            ),

            Obx(()=>
               Container(
                 height: 200 + (homeController.length.value.toDouble() *72),
                margin: EdgeInsets.only(left: 12,right: 12),
                decoration: BoxDecoration(
                  color: YHMColors.newLightTreatment,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Treatments',
                            style: NewTextTheme.axiformaBold,
                          ),
                          GestureDetector(
                            child: Icon(
                              Iconsax.refresh,
                              size: 18,
                            ),
                            onTap: () {homeController.fetchDietPlans(userController.user.value.id);

                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: YHMColors.newDarkTreatment,
                          borderRadius: BorderRadius.circular(100)
                        ),
                        child: Row(

                          children: [
                            Expanded(
                              child: Container(
                                child: TextFormField(
                                  controller: homeController.dName,
                                  decoration: InputDecoration(
                                    fillColor: YHMColors.newDarkTreatment,
                                    hintText: "Enter disease name",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    hintStyle: NewTextTheme.medium!.copyWith(fontSize: 16)
                                        .copyWith(color: YHMColors.newSecondaryTreatment),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  )
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: GestureDetector(
                                onTap: (){homeController.nextScreen();},
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: YHMColors.newLightTreatment),
                                  child: Icon(Iconsax.flash_1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() {

                      if(userController.profileLoading.value) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: YHMShimmerEffectTreatment(
                                width: YHMHelperFunctions.screenWidth(),
                                height: 60,
                                color: YHMColors.newDarkTreatment,
                                radius: 100,),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: YHMShimmerEffectTreatment(
                                width: YHMHelperFunctions.screenWidth(),
                                height: 60,
                                color: YHMColors.newDarkTreatment,
                                radius: 100,),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: YHMShimmerEffectTreatment(
                                width: YHMHelperFunctions.screenWidth(),
                                height: 60,
                                color: YHMColors.newDarkTreatment,
                                radius: 100,),
                            ),

                          ],
                        );
                      }

                      else{ if(homeController.isLoading.value){
                        homeController.fetchDietPlans(userController.user.value.id);
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                              child: YHMShimmerEffectTreatment(width: YHMHelperFunctions.screenWidth(), height: 60,color: YHMColors.newDarkTreatment,radius: 100,),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                              child: YHMShimmerEffectTreatment(width: YHMHelperFunctions.screenWidth(), height: 60,color: YHMColors.newDarkTreatment,radius: 100,),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                              child: YHMShimmerEffectTreatment(width: YHMHelperFunctions.screenWidth(), height: 60,color: YHMColors.newDarkTreatment,radius: 100,),
                            ),

                          ],
                        );
                      }
                      else{
                        if (homeController.dietPlans.isEmpty) {
                          return Center(child: Text('No diet plans found.'));
                        } else {
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: homeController.dietPlans.length,
                              itemBuilder: (context, index) {
                                var dietPlan = homeController.dietPlans[index];
                                return GestureDetector(
                                  onTap: () => Get.to(YHMPersonalizedTreatmentFirebase(diseaseName: dietPlan.diseaseName, paragraph: dietPlan.paragraph, symptoms: dietPlan.symptoms, whatToDo: dietPlan.whatToDo, whatNotToDo: dietPlan.whatNotToDo,graphData: dietPlan.graphData,),transition: Transition.fade,duration: Duration(milliseconds: 600)),
                                  child: YHMTreatmentItemLayout(
                                    title: dietPlan.diseaseName ?? 'No Disease Name',
                                    // Add more fields as needed
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      }

                    }}),



                  ],
                ),
              ),
            ),
            const SizedBox(height: 50,),

            Padding(
              padding: const EdgeInsets.only(left: 20,right: 120),
              child: Image.asset('assets/images/watermark.png',width: YHMHelperFunctions.screenWidth(),fit: BoxFit.fill,),
            ),
            const SizedBox(height: 150,),
          ],
        ),
      ),
    ));
  }
}
