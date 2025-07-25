import 'package:flutter/material.dart';

class FullScreenLoading extends StatelessWidget{
  const FullScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withAlpha(30),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

}