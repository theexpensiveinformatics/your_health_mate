import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

import '../../../personalization/controller/user_controller.dart';
import '../../models/chat/chat_user_model/message_model.dart';
import 'all_chat_list_controller.dart';

class NewChatController extends GetxController {
  var messages = <Message>[].obs;
  final userController = Get.find<UserController>();
  final textController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  final Gemini gemini = Gemini.instance;
  var finalResponse = ''.obs;
  String allMessagesString = '';
  String finalQuestion = '';
  final chatListController = Get.find<AllChatListController>();

  @override
  void onInit() {
    super.onInit();
    _fetchMessages();
  }

  void _fetchMessages() {
    firestore
        .collection('chat_new')
        .doc(userController.user.value.id) // Ensure you have the correct user ID
        .collection('messages')
    .doc(chatListController.selectedSession.value).collection('message')// Use message as document ID
        .orderBy('createdAt', descending: true) // Order messages by creation time
        .snapshots()
        .listen((snapshot) {
      messages.value = snapshot.docs.map((doc) {
        final data = doc.data();
        return Message(
          text: data['text'] ?? '',
          createdAt: (data['createdAt'] as Timestamp).toDate(), // Ensure correct conversion
          isUser: data['isUser'] ?? false,
        );
      }).toList();

      // Combine all messages into a single string
      allMessagesString = messages.value.map((message) {
        return 'Text: ${message.text}, CreatedAt: ${message.createdAt}, IsUser: ${message.isUser}';
      }).join(' | '); // You can choose any delimiter

      // Debugging
      print('All Messages String: $allMessagesString');
    });
  }

  void sendMessage() async {
    if (textController.text.trim().isEmpty) return;

    final now = DateTime.now();
    final userId = userController.user.value.id; // Get user ID from user controller

    final newMessage = Message(
      text: textController.text.trim(),
      createdAt: now,
      isUser: true, // Assuming the message is sent by the user
    );

    try {
      await firestore.collection('chat_new').doc(userId).collection('messages').doc(chatListController.selectedSession.value).collection('message').add({
        'text': newMessage.text,
        'createdAt': Timestamp.fromDate(newMessage.createdAt), // Use Timestamp for Firestore
        'isUser': newMessage.isUser,
      });

      // Ensure allMessagesString is updated before constructing finalQuestion
      await Future.delayed(Duration(milliseconds: 500)); // Adjust delay if needed

      // String promt = 'Listen to me carefully. You are my personal assistant. I will give my old data in the next line. If I ask any question regarding old chat as a string, then you have to answer from it; else, give me an answer like a new conversation, but don\'t say you don\'t have old data access. \n\nOLD CHAT: ';
      // String promt = 'I will share previous chat if you can find answer from that then give me otherwise give me answer accroding to you but never say i dont have old data if you dont find old data then give answer according to you \n\nOLD CHAT: ';
      // String promt = 'I will share previous chat logs for context. If you can find an answer based on that, please provide it. If not, give me an answer based on your own knowledge without mentioning the absence of old data. Please ensure your response is complete and accurate.\n\nOLD CHAT :';
      String promt = 'give answer according to you at rarely some question you can take old chat log \n\nOLD CHAT: ';
      String question = textController.text;
      // Add prompt and question
      finalQuestion = '$question $promt $allMessagesString ';

      // Debugging
      print('Prompt: $promt');
      print('All Messages String: $allMessagesString');
      print('Final Question: $finalQuestion');

      getGeminiResponse(finalQuestion);
      textController.clear(); // Clear the text field after sending
    } catch (e) {
      // Handle errors (e.g., show a snackbar or log the error)
      print('Error sending message: $e');
    }
  }

  void getGeminiResponse(String question) {
    try {
      finalResponse.value = '';

      print('Question: $question');
      gemini.streamGenerateContent(question).listen(
            (event) {
          String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";
          finalResponse.value += response;
          print('Intermediate response: $response');
        },
        onDone: () {
          print('Stream completed.');
          print('Final On Done: ${finalResponse.value}');

          final geminiMessage = Message(
            text: finalResponse.value,
            createdAt: DateTime.now(),
            isUser: false, // Assuming the message is sent by the AI
          );
          firestore.collection('chat_new').doc(userController.user.value.id).collection('messages').doc(chatListController.selectedSession.value).collection('message').add({
            'text': finalResponse.value,
            'createdAt': Timestamp.fromDate(geminiMessage.createdAt), // Use Timestamp for Firestore
            'isUser': geminiMessage.isUser,
          });
          finalResponse.value = '';
        },
      );
    } catch (e) {
      // Handle errors (e.g., show a snackbar or log the error)
      print('Error getting Gemini response: $e');
    }
  }
}
