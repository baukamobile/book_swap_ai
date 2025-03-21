import 'package:book_swap_ai/components/models/gemini_model.dart';
import "package:flutter/material.dart";
import 'package:flutter_gemini/flutter_gemini.dart' as flutter_gemini;
import 'package:google_generative_ai/google_generative_ai.dart' as google_ai;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class GeminiChatPage extends StatefulWidget {
  const GeminiChatPage({super.key});

  @override
  State<GeminiChatPage> createState() => _GeminiChatPageState();
}

class _GeminiChatPageState extends State<GeminiChatPage> {
  TextEditingController promptController = TextEditingController();
  final String apiKeyGemini = dotenv.env['GEMINI_API_KEY'] ?? (throw Exception("API не работает"));
  // "AIzaSyBZHk5VcggP0iGgXHYXfbMJTRkz-kBlSpo";
  late final google_ai.GenerativeModel model;
  // final model = GenerativeModel(model: "gemini-2.0-flash", apiKey: apiKeyGemini);
  final List<GModel> prompt = [];
  @override 
  void initState(){
    super.initState();
  model = GenerativeModel(
    model: "gemini-2.0-flash",
     apiKey: apiKeyGemini);
  }

  @override
void dispose() {
  promptController.dispose();
  super.dispose();
}
  // final bool isPrompt = true;
  Future<void> sendMessage() async {
  final message = promptController.text;
  if (message.isEmpty) return; // Чтобы не отправлять пустые сообщения

  setState(() {
    prompt.add(GModel(
      isPrompt: true,
      message: message,
      time: DateTime.now(),
    ));
  });

  promptController.clear(); // Очищаем поле ввода после отправки

  try {
    final response = await model.generateContent([google_ai.Content.text(message)]);

    setState(() {
      prompt.add(GModel(
        isPrompt: false,
        message: response.text ?? "Ошибка ответа",
        time: DateTime.now(),
      ));
    });
  } catch (e) {
    setState(() {
      prompt.add(GModel(
        isPrompt: false,
        message: "Ошибка: ${e.toString()}",
        time: DateTime.now(),
      ));
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("AI Chat"),
        backgroundColor: const Color.fromARGB(255, 155, 198, 163),
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
            itemCount: prompt.length,
            itemBuilder: (context,index){
              final message = prompt[index];
              return UserPrompt(
                isPrompt: message.isPrompt,
                 message: message.message,
                  date: DateFormat('hh:mm a').format(message.time),
                  );
            }
          )),
          Padding(padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                controller: promptController,
                style: TextStyle(
                  color: const Color.fromARGB(255, 124, 120, 120),
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Enter text',
                ),
              ),
              ),
              // Spacer(),
              SizedBox(width: 20),
              GestureDetector(
                onTap: (){
                  sendMessage();
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color.fromARGB(255, 155, 198, 163),
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          ),
          
        ],
      ),
    );
  }

  Container UserPrompt({
    required final bool isPrompt,
     required String message,
    required String date,
     }) {
    return Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: isPrompt ? Colors.green : const Color.fromARGB(255, 90, 89, 89),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    
                    message,
                  style: TextStyle(
                    fontWeight: isPrompt ? FontWeight.bold: FontWeight.normal,
                    fontSize: 18,
                    color: isPrompt ? Colors.black : Colors.white
                  ),),

                  Text(
                  date,
                  style: TextStyle(

                    fontSize: 18,
                    color: isPrompt ? const Color.fromARGB(255, 247, 246, 246) : Colors.white
                  ),),
                ],
              ),
              );
  }
}


