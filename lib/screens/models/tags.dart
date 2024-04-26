import 'package:flutter/material.dart';

Widget tagsBuilder(AsyncSnapshot<List<String>> snapshot) {
  if (snapshot.hasData) {
    return ListView.builder(
      itemCount: snapshot.data?.length ?? 0,
      itemBuilder: (context, index) {
        final tag = snapshot.data?[index] ?? '';
        return ExpansionTile(
          title: Text(tag),
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
                // print('Use Model: $tag');
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
