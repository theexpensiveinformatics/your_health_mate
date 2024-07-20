import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:your_health_mate/features/health/screens/chat/new_chat.dart';
import 'package:your_health_mate/utils/constants/colors.dart';
import '../../controllers/chat/all_chat_list_controller.dart';


class YHMAllChatList extends StatelessWidget {
  YHMAllChatList({super.key});

  final AllChatListController controller = Get.put(AllChatListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(height: 50),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: YHMColors.primary.withOpacity(0.1),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 40,
                        left: 40,
                        child: Image.asset(
                          'assets/images/ai_star.png',
                          width: 50,
                          color: YHMColors.primary,
                        ),
                      ),
                      Positioned(
                        top: -50,
                        right: 0,
                        child: Image.asset(
                          'assets/images/Vector.png',
                          width: 200,
                          color: YHMColors.primary,
                        ),
                      ),
                      Positioned(
                        bottom: 65,
                        left: 25,
                        child: Text(
                          'Your Conversations',
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
                          'Create unlimited chat rooms',
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.textController,
                  decoration: InputDecoration(
                    hintText: 'Create a new session...',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(Iconsax.send_1),
                      onPressed: () {
                        controller.sendMessage();
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.isLoading.value) {
                  return Text('Loading...');
                } else if (controller.chatSessions.isEmpty) {
                  return Text('No chat sessions available');
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.chatSessions.length,
                    itemBuilder: (context, index) {
                      final chatSession = controller.chatSessions[index];
                      return ListTile(
                        title: Container(
                          height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: YHMColors.dark.withOpacity(0.5),width: 0.5)
                        )
                        ,child: Row(
                          children: [
                            const SizedBox(width: 15,),
                            Image.asset('assets/images/ai_star.png',width: 30,color: YHMColors.primary,),
                            const SizedBox(width: 15,),
                            Text(chatSession['message']),
                          ],
                        )),
                        onTap: () {
                          controller.selectedSession.value=chatSession['id'];
                          Get.to(YHMNewChatScreen(chatSession['id']));
                          print('Document ID: ${chatSession['id']}');
                        },
                      );
                    },
                  );
                }
              }),

            ],
          ),
        ),
      ),
    );
  }
}

