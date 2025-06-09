import 'package:flutter/material.dart';
import 'package:yolo_task/widgets/bottom_nav_bar.dart';
import 'screens/home_screen.dart';
import 'screens/yolo_pay_screen.dart';
import 'screens/ginie_screen.dart';

void main() {
  runApp(const YoloApp());
}

class YoloApp extends StatefulWidget {
  const YoloApp({super.key});

  @override
  State<YoloApp> createState() => _YoloAppState();
}

class _YoloAppState extends State<YoloApp> {
 int _selectedIndex = 1; 

     void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final screens = [
    const HomeScreen(),
    const YoloPayScreen(),
    const GinieScreen(),

  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: screens[_selectedIndex],
        bottomNavigationBar:CustomCurvedBottomNavBar(
    selectedIndex: _selectedIndex,
    onItemTapped: _onItemTapped,

  ),
      ),
    );
  }
}
