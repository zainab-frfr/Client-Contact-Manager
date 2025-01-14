import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function onTap; 
  final String text; 
  final Color color;
  
  const MyButton({super.key, required this.onTap, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: (){
          onTap();
        },
        child: Ink(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Center(child: Text(text, style:  const TextStyle(fontWeight: FontWeight.bold),)),
        ),
      ),
    );
  }
}