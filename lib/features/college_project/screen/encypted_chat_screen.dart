import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/encrypted_chat_controller.dart';


class EncryptedChatScreen extends StatelessWidget {
  EncryptedChatScreen({super.key});

  final EncryptedChatController chatController = Get.put(EncryptedChatController());
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Encrypted Chat"),
      ),
      body: Column(
        children: [
          // Message List
          Expanded(
            child: StreamBuilder<List<String>>(
              stream: chatController.getMessages("chatId"), // Replace with your chatId
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No messages yet."));
                }

                final messages = snapshot.data!;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(messages[index]),
                    );
                  },
                );
              },
            ),
          ),
          // Message Input
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    // Encrypt and send message
                    await chatController.sendMessage(
                      _messageController.text,
                      "chatId", // Replace with actual chatId
                      chatController.keyPair.publicKey, // Replace with recipient's public key
                    );
                    _messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
