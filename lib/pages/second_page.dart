import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SecondPage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Second Page: $count'),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  count++;
                });
              },
              child: Text('Increment'),
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/third');
              },
              child: Text('Third Page'),
            )
          ],
        ),
      ),
    );
  }
}
