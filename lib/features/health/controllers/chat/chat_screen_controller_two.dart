import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../personalization/controller/user_controller.dart';
import '../../models/chat/chat_user_model/message_model.dart';

class ChatScreenController extends GetxController {
  var messages = <Message>[].obs;
  final userController = Get.find<UserController>();

  final currentUser = "User";
  final geminiUser = "Bujji";
  final Gemini gemini = Gemini.instance;
  String response = "";
  var isLoading = false.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
  }

  void clearMessages() {
    isLoading.value = true;
    messages.clear();
    isLoading.value = false;
  }

  void sendMessage(String text) {
    Message message = Message(
      text: text,
      createdAt: DateTime.now(),
      isUser: true,
    );

    messages.insert(0, message);

    isLoading.value = true;

    // Save user message to Firestore
    saveMessageToFirestore(message);

    try {
      String question = text;

      // Check if the user's message is health-related
      bool isHealthRelated = isHealthRelatedQuestion(question);

      // Concatenate additional message if not health-related
      String additionalMessage =
          "Please ask about health only. I am your health assistant.";
      if (!isHealthRelated) {
        question += " $additionalMessage";
      }

      // Simulate Gemini's response
      gemini.streamGenerateContent(
        question,

      ).listen((event) {

        isLoading.value = true;

         response = event.content?.parts?.fold(
            "", (previous, current) => "$previous ${current.text}") ?? "";



        // Notify the UI to update
        messages.refresh();


        isLoading.value = false;
      });
      Message geminiMessage = Message(
        text: response,
        createdAt: DateTime.now(),
        isUser: false,
      );

      saveMessageToFirestore(geminiMessage);

      messages.insert(0, geminiMessage);

      // Save Gemini's response to Firestore
      saveMessageToFirestore(geminiMessage);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  void addLoadingMessage() {
    Message loadingMessage = Message(
      text: "Loading...",
      createdAt: DateTime.now(),
      isUser: false,
    );
    messages.insert(0, loadingMessage);
  }

  bool isHealthRelatedQuestion(String question) {
    // Implement your logic to determine if the question is health-related
    // For example, check keywords or patterns in the question
    return question.contains("health") || question.contains("medical");
  }

  void sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      Message mediaMessage = Message(
        text: "Describe this picture?",
        createdAt: DateTime.now(),
        isUser: true,
      );

      messages.insert(0, mediaMessage);
      sendMessage("Describe this picture?");
    }
  }

  void saveMessageToFirestore(Message message) {
    final chatCollection = firestore
        .collection('chat')
        .doc(userController.user.value.id)
        .collection('messages');

    chatCollection.add({
      'text': message.text,
      'createdAt': message.createdAt,
      'userId': userController.user.value.id,
      'userName': currentUser,
      // Add other fields as necessary
    });
  }
}
