


import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
Color scaffoldBackgroundColor = const Color(0xFF343541);
Color cardColor = const Color(0xFF444654);

// // Declare a String variable for the API key
// String GEMINI_API_KEY = dotenv.env['GEMINI_API_KEY']!;
String GEMINI_API_KEY="apikey";
// // Initialize Gemini with the API key
// Gemini.init(apiKey: GEMINI_API_KEY);
// Declare a String variable for the API key
// String geminiApiKey = dotenv.env['GEMINI_API_KEY']!;

// // Initialize Gemini with the API key (it’s usually done in main.dart, but you can define this here as well)
// void initializeGemini() {
//   Gemini.init(apiKey: geminiApiKey);
// }

// String GEMINI_API_KEY= "AIzaSyDFxhjup4OR2phl-G5k96zda7E-Z5j-iHo";
//openaikey
//openaikey
final ChatMessages = [
{
"msg": "Hello w ho are you?",
"chatIndex": 0,
},
{
"msg": "Hello, I am ChatGPT, a large language model developed by Openal. I am here to assist you,",
"chatIndex": 1,

},
{
"msg": "What is flutter?",
"chatIndex": 2,
},
{
  "msg": "Flutter is an",
  "chatIndex":3
}
];

