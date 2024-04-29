import 'package:flutter/material.dart';
import 'package:offline_ai/api/ollamaapi.dart';

Widget tagsBuilder(AsyncSnapshot<List<String>> snapshot) {
  if (snapshot.hasData) {
    return ListView.builder(
      itemCount: snapshot.data?.length ?? 0,
      itemBuilder: (context, index) {
        final tag = snapshot.data?[index] ?? '';
        final capitalizedTag =
            tag.substring(0, 1).toUpperCase() + tag.substring(1);
        return ExpansionTile(
          title: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            child: Text(capitalizedTag),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'This is the details for $tag',
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // _modelHeaderState.updateModel(tag);
                ApiService.updateSelectedModel(tag);
              },
              child: const Text('Use Model'),
            ),
            const SizedBox(height: 16.0), // Add some spacing
          ],
        );
      },
    );
  } else if (snapshot.hasError) {
    return Center(
      child: Text('Error: ${snapshot.error}'),
    );
  } else {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
