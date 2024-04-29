import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:offline_ai/api/ollamaapi.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:offline_ai/const/color.dart';
import 'package:offline_ai/screens/homescreen/modelHeader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, String>> _conversationHistory = [];
  bool _isSearchLoading = false;
  // late _ModelHeaderState _modelHeaderState;

  @override
  void initState() {
    super.initState();
    // Initialize the _modelHeaderState reference
    // _modelHeaderState = _ModelHeaderState();
  }

  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _generateResponse() async {
    // _searchButtonController.start();
    setState(() {
      _isSearchLoading = true; // Set search loading state to true
    });

    final prompt = _textController.text;
    final response = await ApiService().generateResponse(prompt);

    setState(() {
      _conversationHistory.add({
        'prompt': prompt,
        'response': response,
      });
      _textController.clear();
      _isSearchLoading = false;
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
      body: KeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.enter) {
              final bool isShiftPressed =
                  event.logicalKey.keyLabel.contains("Shift");
              if (!isShiftPressed) {
                _generateResponse();
                return; // Prevent the default behavior
              }
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final containerWidth =
            constraints.maxWidth * 0.85; // 85% of the parent's width

        return Column(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: containerWidth, minWidth: containerWidth),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color.fromARGB(255, 19, 17, 17)
                        : nextcolor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 0,
                        left: 0,
                        child: Icon(Icons.person),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Text(
                          prompt,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0), // Add vertical spacing
          ],
        );
      },
    );
  }

  Widget _buildResponseItem(String response) {
    final isLastResponse = _conversationHistory.last['response'] == response;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final containerWidth =
            constraints.maxWidth * 0.85; // 85% of the parent's width
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: containerWidth),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color.fromARGB(255, 24, 0, 0)
                        : deepnextcolor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        response,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? deepnextcolor
                              : const Color.fromARGB(255, 19, 17, 17),
                        ),
                        selectionControls: materialTextSelectionControls,
                      ),
                      if (isLastResponse)
                        const SizedBox(height: 16.0), // Add bottom margin
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0), // Add a fixed-height box
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField() {
    return Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final maxWidth = constraints.maxWidth * 0.7;

          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 200,
              maxWidth: maxWidth,
            ),
            child: TextField(
              controller: _textController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Enter your prompt here...',
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? const Color.fromARGB(255, 19, 17, 17)
                    : nextcolor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _isSearchLoading
                        ? LoadingAnimationWidget.staggeredDotsWave(
                            color: const Color.fromARGB(255, 243, 33, 243),
                            size: 24,
                          )
                        : IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: _generateResponse,
                          ),
                    // IconButton(
                    //   icon: const Icon(Icons.clear),
                    //   onPressed: _delayedClearTextField,
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
