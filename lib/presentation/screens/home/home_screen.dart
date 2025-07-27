import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Gemini')),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.pink,
              child: Icon(Icons.person_outline),
            ),
            title: Text('Prompt Básico a Gemini'),
            subtitle: Text('Usando un modelo Flash'),
            onTap: () {
              context.push('/basic-prompt');
            },
          ),
        ],
      ),
    );
  }
}
