import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TagFetcher extends StatelessWidget {
  const TagFetcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Modelss'),
      ),
      body: FutureBuilder<List<String>>(
        future: fetchTags(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]),
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
        },
      ),
    );
  }

  Future<List<String>> fetchTags() async {
    final response =
        await http.get(Uri.parse('http://localhost:11434/api/tags'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['models'];
      List<String> tags = [];

      for (var model in data) {
        String name = model['name'];
        if (name.contains(':')) {
          List<String> parts = name.split(':');
          if (parts.length == 2 && parts[1] == 'latest') {
            tags.add(parts[0]);
          } else {
            tags.add(name);
          }
        } else {
          tags.add(name);
        }
      }

      return tags;
    } else {
      throw Exception('Failed to fetch tags');
    }
  }
}
