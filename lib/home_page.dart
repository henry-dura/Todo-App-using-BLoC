import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.blue,
          ),
          Expanded(
              child: Container(
                color: Colors.blue,
                child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
          ),
              ))
        ],
      ),
    );
  }
}
