import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class time1 extends StatefulWidget {
  const time1({super.key});

  @override
  State<time1> createState() => _time1State();
}

class _time1State extends State<time1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time1'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/timeLineFossils'),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            'What did humans evolve from?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          Image.asset(
            'assets/images/monkey.jpg',
          ),
        ],
      ),
    );
  }
}
