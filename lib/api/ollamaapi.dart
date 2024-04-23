import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://localhost:11434/api/generate';
  static final List<String> _conversationHistory = [];

  Future<String> generateResponse(String prompt) async {
    final url = Uri.parse(_baseUrl);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'model': 'mistral',
      'stream': false,
      'prompt': prompt,
      'history': _conversationHistory, // Include the conversation history
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final responseText = data['response'];
        _conversationHistory.add(prompt); // Add the prompt to the history
        _conversationHistory
            .add(responseText); // Add the response to the history
        return responseText;
      } else {
        return 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
