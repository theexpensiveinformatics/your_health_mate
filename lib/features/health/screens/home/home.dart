import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:your_health_mate/common/shimmer/YHMShimmerEffect.dart';
import 'package:your_health_mate/features/health/screens/home/wigets/emoji_container.dart';
import 'package:your_health_mate/utils/constants/colors.dart';
import 'package:your_health_mate/utils/helper/helper_functions.dart';
import 'package:your_health_mate/utils/newTheme/new_text_theme.dart';
import '../../../personalization/controller/user_controller.dart';
import '../chat/chat.dart';

class YHMHomeScreen extends StatelessWidget {
  YHMHomeScreen({super.key});
  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: YHMColors.newLightOrange,
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
                      Image.asset('assets/images/ai_star.png',height: 30,width: 30,),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: YHMColors.newDarkOrange,
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
                Obx(()=> userController.profileLoading == true ? YHMShimmerEffect(width: 30, height: 20):
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                      text: TextSpan(
                        text: 'Hello, ${userController.user.value.firstName} \nHow do you feel \nabout your ',
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
                    Get.to(YHMChatScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 60,
                      width: YHMHelperFunctions.screenWidth(),
                      decoration: BoxDecoration(
                          color: YHMColors.newDarkOrange,
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [

                            Text(
                              'Start Chatting',
                              style: NewTextTheme.medium
                                  .copyWith(fontSize: 16, color: YHMColors.newSecondaryOrange),
                            ),
                            Icon(Iconsax.arrow_right_1,)
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
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Daily Mood log',style: NewTextTheme.axiformaBold,),
                Icon(Iconsax.more4,size: 18,)
            ],),
          ),
          
          const SizedBox(height: 10,),
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


          /// -- logs
          const SizedBox(height: 50,),

          Container(
            margin: EdgeInsets.all(7),
            height: 1000,
            decoration: BoxDecoration(
              color: YHMColors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [BoxShadow(color: YHMColors.dark.withOpacity(0.08),offset: Offset(0.0, -10),blurRadius: 50,spreadRadius: -5)
              ]
            ),
            child: Column(
              children: [
                const SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Your Logs',style: NewTextTheme.axiformaBold,),
                      Icon(Iconsax.more4,size: 18,)
                    ],),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
