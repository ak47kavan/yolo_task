import 'package:flutter/material.dart';

class GinieScreen extends StatelessWidget {
  const GinieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Ginie Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
