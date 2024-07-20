import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:your_health_mate/common/appbar/blur_appbar.dart';
import 'package:your_health_mate/utils/newTheme/new_text_theme.dart';
import '../../../../utils/constants/colors.dart';
import '../../controllers/chat/new_chat_controller.dart';

class YHMNewChatScreen extends StatelessWidget {
  YHMNewChatScreen( this.chatSession);

  final String chatSession;
  @override
  Widget build(BuildContext context) {
    final NewChatController controller = Get.put(NewChatController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFF8F8F8),
      appBar: YHMBlurAppBar(
        title: chatSession,
        showBackArrow: false,
      ),
      body: Stack(
        children: [
          // Chat messages list
          Positioned.fill(bottom: 60,
            child: Obx(() {
              return Container(
                color: Color(0xFFF8F8F8),
                child: ListView.builder(
                  reverse: true, // To keep the latest messages at the bottom
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    return message.isUser == true ? Container(
                      padding: EdgeInsets.only(left: 80,right: 10,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                              decoration: BoxDecoration(
                                color: YHMColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.only(topLeft:  Radius.circular(15),topRight:  Radius.circular(15),bottomRight:  Radius.circular(5),bottomLeft: Radius.circular(15)),
                              ),
                              child: Expanded(
                                child: Text(
                                  message.text,style: NewTextTheme.regular,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ):   Container(
                      padding: EdgeInsets.only(right: 80,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(width: 5,),
                          Image.asset('assets/images/ai_star.png',width: 20,color: YHMColors.primary,),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                              decoration: BoxDecoration(
                                color: YHMColors.white,
                                borderRadius: BorderRadius.only(topLeft:  Radius.circular(15),topRight:  Radius.circular(15),bottomRight:  Radius.circular(15),bottomLeft: Radius.circular(5)),
                              ),
                              child: Expanded(
                                child: Text(
                                  message.text,style: NewTextTheme.regular,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          // Input field and send button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.textController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      controller.sendMessage(); // Send the message when the button is pressed
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
