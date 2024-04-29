import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModelHeader extends StatefulWidget {
  const ModelHeader({Key? key}) : super(key: key);

  @override
  ModelHeaderState createState() => ModelHeaderState();
}

class ModelHeaderState extends State<ModelHeader> {
  String _currentModel = 'llama2'; // Initialize with the default model

  void updateModel(String newModel) {
    setState(() {
      _currentModel = newModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.model_training),
          const SizedBox(width: 8.0),
          Text(
            'Current Model: $_currentModel',
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
