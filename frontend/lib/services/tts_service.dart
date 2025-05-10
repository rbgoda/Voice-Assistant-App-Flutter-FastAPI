import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getAudioFromTts(String text, String lang) async {
  final uri = Uri.parse('http://localhost:8000/tts');
  final response = await http.post(uri, body: jsonEncode({"text": text, "lang": lang}));
  final json = jsonDecode(response.body);
  return json['audio_url'];
}
