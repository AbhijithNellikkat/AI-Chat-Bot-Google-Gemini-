import 'dart:convert';
import 'dart:developer';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  ChatUser chatUser = ChatUser(id: '1', firstName: 'Abhijith');
  ChatUser bot = ChatUser(id: '2', firstName: 'Gemini');

  List<ChatMessage> allMessages = [];

  List<ChatUser> typing = [];

  static const baseURl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyDh1PHsAmdQ6K-MYWLqvEbfQXEClZ4ZBXI';

  final headers = {'Content-Type': 'application/json'};

  // Add proper error handling
  Future<void> getData({required ChatMessage chatMessage}) async {
    try {
      typing.add(bot);
      allMessages.insert(0, chatMessage);
      setState(() {});

      var data = {
        "contents": [
          {
            "parts": [
              {"text": chatMessage.text}
            ]
          }
        ]
      };

      final response = await http.post(
        Uri.parse(baseURl),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log("Result : $result");

        if (result['candidates'] != null &&
            result['candidates'].isNotEmpty &&
            result['candidates'][0]['content'] != null &&
            result['candidates'][0]['content']['parts'] != null &&
            result['candidates'][0]['content']['parts'].isNotEmpty) {
          ChatMessage chatMessage1 = ChatMessage(
            user: bot,
            text: result['candidates'][0]['content']['parts'][0]['text'],
            createdAt: DateTime.now(),
          );

          allMessages.insert(0, chatMessage1);
          setState(() {});
        } else {
          log("Invalid response format");
        }
      } else {
        log("Error: ${response.statusCode}");
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      typing.remove(bot);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Gemini Chat',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: DashChat(
        typingUsers: typing,
        currentUser: chatUser,
        onSend: (message) {
          getData(chatMessage: message);
          log("Send");
        },
        messageOptions: MessageOptions(
          messageDecorationBuilder: (message, previousMessage, nextMessage) {
            return BoxDecoration(
              color: message.user == chatUser
                  ? const Color.fromARGB(255, 144, 141, 141)
                  : const Color.fromARGB(255, 219, 218, 218),
              borderRadius: BorderRadius.circular(8.0),
            );
          },
        ),
        inputOptions: InputOptions(
          alwaysShowSend: true,
          cursorStyle: const CursorStyle(color: Colors.black),
          sendButtonBuilder: (onPressed) {
            return IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.send),
              color: Colors.blue, // Set send button color
            );
          },
        ), //
        messages: allMessages,
      ),
    );
  }
}
