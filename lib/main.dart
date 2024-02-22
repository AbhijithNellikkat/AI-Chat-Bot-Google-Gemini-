import 'package:flutter/material.dart';
import 'package:google_gemini/chat_bot.dart';

void main() {
  runApp(const MyApp());

  // AIzaSyDh1PHsAmdQ6K-MYWLqvEbfQXEClZ4ZBXI

  // curl \
  // -H 'Content-Type: application/json' \
  // -d '{"contents":[{"parts":[{"text":"Write a story about a magic backpack"}]}]}' \
  // -X POST https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=YOUR_API_KEY
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ChatBot(),
    );
  }
}

