import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: Colors.amber,
  
      child: const SizedBox(height: 300,width: 200,),
    );
  }
}