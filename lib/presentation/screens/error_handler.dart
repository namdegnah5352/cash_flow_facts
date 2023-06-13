import 'package:flutter/material.dart';

class ErrorHandler extends StatelessWidget {
  final String message;
  const ErrorHandler({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Oops and error occurred')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(message),
          ],
        ),
      ),
    );
  }
}
