import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  ChatUser chatUser = ChatUser(id: '1', firstName: 'Abhijith');
  ChatUser bot = ChatUser(id: '2', firstName: 'Gemini');

  List<ChatMessage> allMessages = [];

  getData({required ChatMessage chatMessage}) {
    allMessages.insert(0, chatMessage);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashChat(
        currentUser: chatUser,
        onSend: (message) {
          getData(chatMessage: message);
        },
        messages: allMessages,
      ),
    );
  }
}
