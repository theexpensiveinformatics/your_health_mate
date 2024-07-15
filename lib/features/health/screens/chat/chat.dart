import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:your_health_mate/utils/constants/colors.dart';
import 'package:your_health_mate/utils/helper/helper_functions.dart';
import 'package:your_health_mate/utils/newTheme/new_text_theme.dart';
import '../../../personalization/screens/setting/widgets/circular_image.dart';
import '../../controllers/chat/chat_screen_controller.dart';

class YHMChatScreen extends StatelessWidget {
  final ChatScreenController controller = Get.put(ChatScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Obx(() => Container(
          color: Color(0xFFf8f8f8),
          child: Stack(
            children: [
              AnimatedSwitcher(
                reverseDuration: Duration(milliseconds: 200),
                duration: Duration(milliseconds: 500),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: DashChat(
                    key: UniqueKey(),
                    // Ensure a unique key for proper animation
                    messageOptions: MessageOptions(
                      avatarBuilder: (ChatUser user, Function? onPressAvatar,
                          Function? onLongPressAvatar) {
                        return YHMCircularImage(
                          image: 'assets/images/ai_star.png',
                          width: 40,
                          overlayColor: YHMColors.primary,
                          backgroundColor: Colors.transparent,
                          height: 40,
                          fit: BoxFit.cover,
                        );
                      },
                      messageDecorationBuilder: (ChatMessage message,
                          ChatMessage? previousMessage,
                          ChatMessage? nextMessage) {
                        return _customMessageDecorationBuilder(message);
                      },
                      messageTextBuilder: (ChatMessage message,
                          ChatMessage? previousMessage,
                          ChatMessage? nextMessage) {
                        return _customMessageTextBuilder(message);
                      },
                    ),
                    inputOptions: InputOptions(
                      sendButtonBuilder: (onSend) {
                        return Container(
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: YHMColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            onPressed: onSend,
                            icon: const Icon(Iconsax.send_1,color: YHMColors.primary,),
                          ),
                        );
                      },
                      inputDecoration: InputDecoration(
                        prefixIcon: Container(
                          margin: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Color(0xFFf8f8f8),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            onPressed: controller.sendMediaMessage,
                            icon: const Icon(Iconsax.image),
                          ),
                        ),
                        hintText: "Type a message...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        hintStyle: NewTextTheme.regular!.copyWith(fontSize: 15)
                            .copyWith(color: YHMColors.dark.withOpacity(0.5)),
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
                      ),
                    ),
                    currentUser: controller.currentUser,
                    onSend: controller.sendMessage,
                    messages: controller.messages,
                  ),
                ),
              ),

              controller.messages.isEmpty ? Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Transform.scale(scale: 2.2,child: Lottie.asset('assets/lottie/blur.json',width: 200,height: 200,)),
                      Positioned(left:40,right: 40,top: 40,bottom: 40,child: YHMCircularImage(image: 'assets/images/bujji.png',radius: 100,padding: 0,width: 100,height: 100,))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40,right: 40),
                    child: Text('I\'m your personal health Assistant. How can i help you?',style: NewTextTheme.medium!.copyWith(fontSize: 20,height: 1.2),textAlign: TextAlign.center,),
                  ),


                ],
              )): Center(),

              // Loading Indicator
              if (controller.isLoading.value)
                Positioned.fill(
                  child: Container(),
                ),

              // App Bar
              Positioned(
                top: 0,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: YHMColors.dark.withOpacity(0.03),
                        blurRadius: 20,
                        offset: Offset(0, 10))
                  ]),
                  width: YHMHelperFunctions.screenWidth(),
                  padding: const EdgeInsets.only(
                      top: 45, right: 25, left: 25, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          YHMCircularImage(
                            padding: 0,
                            image: 'assets/images/bujji.png',
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                "Bujji",
                                style: NewTextTheme.axiformaRegular!
                                    .copyWith(fontSize: 15,height: 1.2),
                              ),
                              Text('Health Assistant',style: NewTextTheme.axiformaRegular!.copyWith(fontSize: 12,color: YHMColors.dark.withOpacity(0.5),height: 1.3),)
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){controller.clearMessage();},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              decoration: BoxDecoration(
                                color: Color(0xFFf8f8f8),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                'New Chat',
                                style: NewTextTheme.axiformaRegular!
                                    .copyWith(fontSize: 12),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  BoxDecoration _customMessageDecorationBuilder(ChatMessage message) {
    bool isUser = message.user.id == controller.currentUser.id;
    return BoxDecoration(
      color: isUser ? Colors.blue : Colors.white,
      borderRadius: isUser
          ? const BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(3),
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            )
          : const BorderRadius.only(
              bottomLeft: Radius.circular(3),
              bottomRight: Radius.circular(18),
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
    );
  }

  Widget _customMessageTextBuilder(ChatMessage message) {
    bool isUser = message.user.id == controller.currentUser.id;
    final text = message.text ?? '';

    // Check for bold patterns and format accordingly
    final boldPattern = RegExp(r'\*\*(.*?)\*\*');
    final matches = boldPattern.allMatches(text);

    // If there are bold patterns found, format them
    if (matches.isNotEmpty) {
      List<TextSpan> children = [];

      int start = 0;
      for (RegExpMatch match in matches) {
        // Add preceding non-bold text
        if (match.start > start) {
          children.add(TextSpan(
            text: text.substring(start, match.start),
            style: isUser
                ? NewTextTheme.regular?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.normal)
                : NewTextTheme.regular?.copyWith(
                    color: Colors.black, fontWeight: FontWeight.normal),
          ));
        }

        // Add bold text
        children.add(TextSpan(
          text: match.group(1), // Extract the bold text without the **
          style: isUser
              ? NewTextTheme.regular
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
              : NewTextTheme.regular
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
        ));

        start = match.end;
      }

      // Add remaining non-bold text
      if (start < text.length) {
        children.add(TextSpan(
          text: text.substring(start),
          style: isUser
              ? NewTextTheme.regular
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.normal)
              : NewTextTheme.regular?.copyWith(
                  color: Colors.black, fontWeight: FontWeight.normal),
        ));
      }

      return RichText(
        text: TextSpan(children: children),
      );
    }

    // If no bold pattern is found, render as usual
    return Text(
      text,
      style: isUser
          ? NewTextTheme.regular?.copyWith(color: Colors.white)
          : NewTextTheme.regular?.copyWith(color: Colors.black),
    );
  }
}
