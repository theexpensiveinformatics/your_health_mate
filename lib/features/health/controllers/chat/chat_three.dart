// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:your_health_mate/utils/constants/colors.dart';
// import 'package:your_health_mate/utils/helper/helper_functions.dart';
// import 'package:your_health_mate/utils/newTheme/new_text_theme.dart';
// import '../../../personalization/screens/setting/widgets/circular_image.dart';
// import '../../controllers/chat/chat_screen_controller.dart';
// import '../../models/chat/chat_user_model/message_model.dart';
//
// class YHMChatScreen extends StatelessWidget {
//   final ChatScreenController controller = Get.put(ChatScreenController());
//   final TextEditingController textController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildUI(),
//     );
//   }
//
//   Widget _buildUI() {
//     return Container(
//       color: Color(0xFFf8f8f8),
//       child: Stack(
//         children: [
//           if (controller.messages.isEmpty)
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Stack(
//                     children: [
//                       Transform.scale(
//                         scale: 2.2,
//                         child: Lottie.asset(
//                           'assets/lottie/blur.json',
//                           width: 200,
//                           height: 200,
//                         ),
//                       ),
//                       Positioned(
//                         left: 40,
//                         right: 40,
//                         top: 40,
//                         bottom: 40,
//                         child: YHMCircularImage(
//                           image: 'assets/images/bujji.png',
//                           radius: 100,
//                           padding: 0,
//                           width: 100,
//                           height: 100,
//                         ),
//                       )
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 40, right: 40),
//                     child: Text(
//                       'I\'m your personal health Assistant. How can I help you?',
//                       style: NewTextTheme.medium!
//                           .copyWith(fontSize: 20, height: 1.2),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ListView.builder(
//             reverse: true,
//             itemCount: controller.messages.length,
//             itemBuilder: (context, index) {
//               final message = controller.messages[index];
//               // return _buildMessageItem(message);
//             },
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: YHMColors.dark.withOpacity(0.03),
//                     blurRadius: 20,
//                     offset: Offset(0, -10),
//                   )
//                 ],
//               ),
//               padding: const EdgeInsets.all(10),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: textController,
//                       decoration: InputDecoration(
//                         hintText: "Type a message...",
//                         contentPadding: EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 15,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(100),
//                           borderSide: BorderSide.none,
//                         ),
//                         filled: true,
//                         fillColor: Color(0xFFf8f8f8),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   IconButton(
//                     icon: Icon(Icons.send, color: YHMColors.primary),
//                     onPressed: () {
//                       if (textController.text.isNotEmpty) {
//                         controller.sendMessage(textController.text);
//                         textController.clear();
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (controller.isLoading.value)
//             Positioned.fill(
//               child: Container(
//                 color: Colors.black.withOpacity(0.5),
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessageItem(Message message) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       alignment:
//       message.isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: message.isUser ? Colors.blue : Colors.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           message.text,
//           style: TextStyle(
//             color: message.isUser ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
