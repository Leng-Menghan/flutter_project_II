import 'package:flutter/material.dart';

class CustomOutlineButton extends StatefulWidget {
  const CustomOutlineButton({super.key});

  @override
  State<CustomOutlineButton> createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(18),
          side: BorderSide(color: Color(0xFF438883), width: 2),
        ),
        child: Text("Add", style: TextStyle(fontSize: 16, color: Color(0xFF438883))),
        onPressed: (){},
      ),
    );
  }
}