import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({
    super.key,
    required this.value,
    required this.unit,
    required this.imageUrl,
    required this.text,
  });

  final int value;
  final String unit;
  final String imageUrl;
  final String text;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: size.width*.2,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent),
            child: Image.asset(imageUrl),
          ),
          Text(text,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
          const SizedBox(height: 5),
          Text(
            value.toString() + unit,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white,fontSize: 12),
          )
        ],
      ),
    );
  }
}
