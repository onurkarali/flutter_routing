import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/second_page.dart';

class RootPage extends StatefulWidget {
  final String title;
  const RootPage({super.key, required this.title});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  count++;
                });
              },
              child: Column(
                children: [
                  Center(
                    child: Text('Root Page: $count'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return SecondPage();
                },
              ));
            },
            child: Text('Go to Second Page'),
          ),
        ],
      ),
    );
  }
}
