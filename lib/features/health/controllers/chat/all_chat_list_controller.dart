import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../personalization/controller/user_controller.dart';

class AllChatListController extends GetxController {
  var chatSessions = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final selectedSession = ''.obs;
  final userController = Get.find<UserController>();
  final textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchChatSessions();
  }

  void fetchChatSessions() async {
    try {
      isLoading.value = true;
      final userId = userController.user.value.id;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('chat_new')
          .doc(userId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .get();

      chatSessions.clear();
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        chatSessions.add({
          ...data,
          'id': doc.id, // Include document ID if needed
        });
      }
      isLoading.value = false;
    } catch (e) {
      print('Error fetching chat sessions: $e');
      isLoading.value = false;
    }
  }

  void sendMessage() async {
    try {
      final userId = userController.user.value.id;
      final message = textController.text.trim();

      if (message.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('chat_new')
            .doc(userId)
            .collection('messages')
            .doc(message) // Use message as document ID
            .set({
          'message': message,
          'timestamp': FieldValue.serverTimestamp(),
        });

        textController.clear();
        fetchChatSessions();
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}
