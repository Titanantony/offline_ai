import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:offline_ai/api/ollamaapi.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, String>> _conversationHistory = [];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _generateResponse() async {
    final prompt = _textController.text;
    final response = await ApiService().generateResponse(prompt);
    setState(() {
      _conversationHistory.add({
        'prompt': prompt,
        'response': response,
      });
      _textController.clear();
    });
  }

  void _delayedClearTextField() {
    Future.delayed(const Duration(milliseconds: 200), () {
      _textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (RawKeyEvent event) {
          if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
            if (event.isShiftPressed) {
              _textController.value = TextEditingValue(
                text: "${_textController.text}\n",
                selection: TextSelection.collapsed(
                  offset: _textController.text.length + 1,
                ),
              );
            } else {
              _generateResponse();
            }
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildConversationItems(),
                ),
              ),
            ),
            _buildTextField(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildConversationItems() {
    List<Widget> items = [];
    for (var item in _conversationHistory) {
      items.add(_buildPromptItem(item['prompt']!));
      items.add(_buildResponseItem(item['response']!));
    }
    return items;
  }

  Widget _buildPromptItem(String prompt) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          const Icon(Icons.person),
          const SizedBox(width: 8.0),
          Text(
            prompt,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildResponseItem(String response) {
    final isLastResponse = _conversationHistory.last['response'] == response;

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            response,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          if (isLastResponse) const SizedBox(height: 16.0), // Add bottom margin
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 200,
          maxWidth: 600,
        ),
        child: TextField(
          controller: _textController,
          maxLines: null,
          decoration: InputDecoration(
            hintText: 'Enter your prompt here...',
            filled: true,
            fillColor: const Color.fromARGB(255, 228, 219, 219),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _generateResponse,
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _delayedClearTextField,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
