import 'package:flutter/material.dart';
import 'package:offline_ai/screens/models/models_api_service.dart';
import 'package:offline_ai/screens/models/tags.dart';

class TagFetcher extends StatelessWidget {
  const TagFetcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Models'),
      ),
      body: FutureBuilder<List<String>>(
        future: fetchTags(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Call the tagsBuilder function directly
            return tagsBuilder(snapshot);
          }
        },
      ),
    );
  }
}
