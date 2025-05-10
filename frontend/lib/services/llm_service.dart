import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> askLlm(String text) async {
  final uri = Uri.parse('http://localhost:8000/ask');
  final response = await http.post(uri, body: jsonEncode({"text": text}));
  final json = jsonDecode(response.body);
  return json['response'];
}
