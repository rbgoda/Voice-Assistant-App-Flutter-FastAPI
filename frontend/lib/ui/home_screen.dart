import 'package:flutter/material.dart';
import '../services/stt_service.dart';
import '../services/llm_service.dart';
import '../services/tts_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isRecording = false;
  String transcript = "";
  String response = "";
  String audioUrl = "";

  void startListening() async {
    setState(() { isRecording = true; });
    final text = await sendAudioToStt(); // Simulated for demo
    setState(() { transcript = text; });

    final answer = await askLlm(text);
    setState(() { response = answer; });

    final url = await getAudioFromTts(answer, "en-US");
    setState(() { audioUrl = url; });

    setState(() { isRecording = false; });
  }

  Future<String> sendAudioToStt() async {
    return "What is the weather today?";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Voice Assistant")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: startListening,
              icon: Icon(isRecording ? Icons.stop : Icons.mic),
              label: Text(isRecording ? "Stop Recording" : "Start Talking"),
            ),
            const SizedBox(height: 20),
            Text("You said: $transcript"),
            Text("Assistant: $response"),
            if (audioUrl.isNotEmpty) Text("Audio ready: $audioUrl"),
          ],
        ),
      ),
    );
  }
}
