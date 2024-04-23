import 'package:flutter/material.dart';
import 'package:offline_ai/api/ollamaapi.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();
  String _response = '';
  List<String> _conversationHistory = [];

  Future<void> generateResponse() async {
    final prompt = _textController.text;
    final response = await ApiService().generateResponse(prompt);
    setState(() {
      _response = response;
      _conversationHistory.add(prompt); // Add the prompt to the history
      _conversationHistory.add(response); // Add the response to the history
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Enter your prompt here...',
              ),
            ),
            ElevatedButton(
              onPressed: generateResponse,
              child: Text('Generate Response'),
            ),
            SizedBox(height: 16.0),
            Text(_response),
          ],
        ),
      ),
    );
  }
}
