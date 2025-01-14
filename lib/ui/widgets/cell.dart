import 'package:flutter/material.dart';

class MyCell extends StatelessWidget {
  final String content;
  final bool header; 
  const MyCell({super.key, required this.content, required this.header});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        content, 
        style: (header)? const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
              : const TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }
}