  import 'dart:io';
  import 'dart:typed_data';
  import 'package:dash_chat_2/dash_chat_2.dart';
  import 'package:flutter_gemini/flutter_gemini.dart';
  import 'package:get/get.dart';
  import 'package:image_picker/image_picker.dart';

  class ChatScreenController extends GetxController {
    final Gemini gemini = Gemini.instance;

    var messages = <ChatMessage>[].obs;

    ChatUser currentUser = ChatUser(id: "0", firstName: "User");
    ChatUser geminiUser = ChatUser(
      id: "1",
      firstName: "Bujji",
      profileImage: "https://firebasestorage.googleapis.com/v0/b/your-health-mate.appspot.com/o/ai_star.png?alt=media&token=882b29b4-3929-4f10-b543-2cf7df448872",
    );

    var isLoading = false.obs;

    @override
    void onInit() {
      super.onInit();

    }

    void clearMessage(){
      isLoading.value = true;
      messages.clear();
      isLoading.value = false;
    }

    void sendMessage(ChatMessage chatMessage) {

      messages.insert(0, chatMessage);
      addLoadingMessage();
      isLoading.value = true;


      try {
        String question = chatMessage.text;

        // Check if the user's message is health-related
        bool isHealthRelated = isHealthRelatedQuestion(question);

        // Concatenate additional message if not health-related
        String additionalMessage = "Please ask about health only. I am your health assistant.";
        if (!isHealthRelated) {
          question += " $additionalMessage";
        }

        List<Uint8List>? images;
        if (chatMessage.medias?.isNotEmpty ?? false) {
          images = [
            File(chatMessage.medias!.first.url).readAsBytesSync(),
          ];
        }

        gemini.streamGenerateContent(
          question,
          images: images,
        ).listen((event) {
          removeLoadingMessage();
          isLoading.value = true;



          String response = event.content?.parts?.fold(
              "", (previous, current) => "$previous ${current.text}") ?? "";

          if (messages.isNotEmpty && messages.first.user == geminiUser) {
            // Update the existing message if the last message is from Gemini user
            messages[0] = messages[0].copyWith(
              text: messages[0].text + response,
            );
          } else {
            // Insert a new message if the last message is not from Gemini user
            ChatMessage message = ChatMessage(
              user: geminiUser,
              createdAt: DateTime.now(),
              text: response,
            );
            messages.insert(0, message);
          }

          // Notify the UI to update
          messages.refresh();
          isLoading.value = false;

        });
      } catch (e) {
        isLoading.value = false;
        print(e);
      }
    }

    void addLoadingMessage() {
      ChatMessage loadingMessage = ChatMessage(
        user: geminiUser,
        createdAt: DateTime.now(),
        text: "Loading...",
      );
      messages.insert(0, loadingMessage);
    }

    void removeLoadingMessage() {
      messages.removeWhere((message) => message.user == geminiUser && message.text == "Loading...");
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
        ChatMessage chatMessage = ChatMessage(
          user: currentUser,
          createdAt: DateTime.now(),
          text: "Describe this picture?",
          medias: [
            ChatMedia(
              url: file.path,
              fileName: "",
              type: MediaType.image,
            )
          ],
        );
        sendMessage(chatMessage);
      }
    }
  }

  extension on ChatMessage {
    ChatMessage copyWith({String? text, DateTime? createdAt, ChatUser? user}) {
      return ChatMessage(
        text: text ?? this.text,
        createdAt: createdAt ?? this.createdAt,
        user: user ?? this.user,
        medias: medias, // add other fields as necessary
      );
    }
  }
