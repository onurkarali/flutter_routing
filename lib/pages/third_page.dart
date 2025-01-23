import 'package:flutter/material.dart';

class ThirPage extends StatefulWidget {
  const ThirPage({super.key});

  @override
  State<ThirPage> createState() => _ThirPageState();
}

class _ThirPageState extends State<ThirPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Third Page'),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
