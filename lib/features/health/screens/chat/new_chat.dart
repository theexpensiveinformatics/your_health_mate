import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:your_health_mate/common/appbar/blur_appbar.dart';
import 'package:your_health_mate/utils/newTheme/new_text_theme.dart';
import '../../../../utils/constants/colors.dart';
import '../../controllers/chat/new_chat_controller.dart';

class YHMNewChatScreen extends StatelessWidget {
  YHMNewChatScreen(this.chatSession);

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
          Positioned.fill(
            bottom: 75,
            child: Obx(() {
              return Container(
                color: Color(0xFFF8F8F8),
                child: ListView.builder(
                  reverse: true, // To keep the latest messages at the bottom
                  itemCount: controller.messages.length +
                      (controller.responseLoading.value ? 1 : 0), // Add 1 if loading
                  itemBuilder: (context, index) {
                    // Show AI loading message if response is loading
                    if (controller.responseLoading.value && index == 0) {
                      return _buildLoadingMessage();
                    }

                    final messageIndex = controller.responseLoading.value ? index - 1 : index;
                    final message = controller.messages[messageIndex];

                    // User message
                    if (message.isUser) {
                      return _buildUserMessage(message.text);
                    } else {
                      // AI message
                      return _buildAIMessage(message.text);
                    }
                  },
                ),
              );
            }),
          ),

          // Input field and send button
          Positioned(
            bottom: 5,
            left: 5,
            right: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(1000),
                    border: Border.all(
                      color: YHMColors.primary.withOpacity(0.1),
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.textController,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: 'Ask me about health...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: YHMColors.primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Obx(
                              () => controller.responseLoading.value == false
                              ? IconButton(
                            icon: Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              controller.sendMessage(); // Send the message when the button is pressed
                            },
                          )
                              : Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the user message bubble
  Widget _buildUserMessage(String text) {
    return Container(
      padding: EdgeInsets.only(left: 80, right: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: YHMColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(5),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              child: Text(
                text,
                style: NewTextTheme.regular,
                softWrap: true, // Allows text to wrap into multiple lines
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the AI message bubble
  Widget _buildAIMessage(String text) {
    return Container(
      padding: EdgeInsets.only(right: 80, bottom: 10,left:20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            'assets/images/ai_star.png',
            width: 20,
            color: YHMColors.primary,
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: YHMColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: RichText(
                text: parseTextWithBold(
                  text,
                  NewTextTheme.regular.copyWith(color: YHMColors.dark), // Default text style
                  NewTextTheme.regular
                      .copyWith(fontWeight: FontWeight.bold, color: YHMColors.dark),
                ),
                softWrap: true, // Allows text to wrap into multiple lines
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the loading message for AI
  Widget _buildLoadingMessage() {
    return Container(
      padding: EdgeInsets.only(right: 80, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            'assets/images/ai_star.png',
            width: 20,
            color: YHMColors.primary,
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: YHMColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: Text(
                'AI is typing...',
                style: NewTextTheme.regular.copyWith(color: YHMColors.primary),
              ).animate(onPlay: (controller) => controller.repeat(),).fade(begin: 0.4,end:1.0,duration: 1000.ms,curve: Curves.easeIn).then(duration: 1000.ms).fade(end: 0.4,begin:1.0,curve: Curves.easeOut,duration:1000.ms),
            ).animate(onPlay: (controller) => controller.repeat()).shimmer(color: YHMColors.primary.withOpacity(0.1),duration: 1800.ms),
          ),
        ],
      ),
    );
  }

  TextSpan parseTextWithBold(String text, TextStyle normalStyle, TextStyle boldStyle) {
    final List<TextSpan> spans = [];
    final RegExp pattern =
    RegExp(r'(\*\*[^*]+\*\*)|(\* )|([^*]+)'); // Matches **bold** text, * for bullets, and normal text.
    final matches = pattern.allMatches(text);

    for (final match in matches) {
      final matchedText = match[0]!;

      if (matchedText.startsWith('**') && matchedText.endsWith('**')) {
        // Handle **bold** text
        final boldText = matchedText.substring(2, matchedText.length - 2);
        spans.add(TextSpan(text: boldText, style: boldStyle));
      } else if (matchedText == '* ') {
        // Replace "* " with "• "
        spans.add(TextSpan(text: '• ', style: normalStyle));
      } else {
        // Handle normal text
        spans.add(TextSpan(text: matchedText, style: normalStyle));
      }
    }

    return TextSpan(children: spans);
  }
}
