import 'package:flutter/material.dart';
import '../../domain/calls/calls.dart';
import 'app_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('Cash Flow Facts')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            FilledButton.tonal(
              onPressed: () => loadSettings(),
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
