import 'package:flutter/material.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton({super.key, required this.text, required this.onPressed});
  final String text;
  final  void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(



      style: ElevatedButton.styleFrom(
        fixedSize: Size.fromHeight(60),
        backgroundColor: Color(0xffFF5E00),
      ),
      onPressed:onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
