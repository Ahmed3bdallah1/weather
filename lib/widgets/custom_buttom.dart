import 'package:flutter/material.dart';
import 'package:weather_app/models/constant.dart';



//this is for
class CustomShapeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomShapeButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Constants constants=Constants();
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width * 0.75,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: constants.primaryColor.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
    );
  }
}