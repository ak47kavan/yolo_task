import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/faker_service.dart';
import '../models/car_model.dart';

class YoloPayScreen extends StatefulWidget {
  const YoloPayScreen({super.key});

  @override
  State<YoloPayScreen> createState() => _YoloPayScreenState();
}

class _YoloPayScreenState extends State<YoloPayScreen> with SingleTickerProviderStateMixin {
  bool isFrozen = false;
  late Future<CardModel> cardFuture;
  late AnimationController _controller;
  late Animation<double> _blurAnimation;

  @override
  void initState() {
    super.initState();
    cardFuture = FakerService.fetchCardDetails();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _blurAnimation = Tween<double>(begin: 0, end: 6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void toggleFreeze() {
    setState(() {
      isFrozen = !isFrozen;
      isFrozen ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                'select payment mode',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'choose your preferred payment method to make payment.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
  onPressed: () {},
  style: OutlinedButton.styleFrom(
    side: const BorderSide(color: Colors.red, width: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    backgroundColor: Colors.black.withOpacity(0.2),
    padding: const EdgeInsets.symmetric(vertical: 12),
  ),
  child: const Text("pay", style: TextStyle(color: Colors.red)),
),
                    ),
                  
                  const SizedBox(width: 16),
                  Expanded(
                    child:OutlinedButton(
  onPressed: () {},
  style: OutlinedButton.styleFrom(
    side: const BorderSide(color: Colors.white, width: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    backgroundColor: Colors.black.withOpacity(0.2),
    padding: const EdgeInsets.symmetric(vertical: 12),
  ),
  child: const Text("card", style: TextStyle(color: Colors.white)),
),
                    ),
                  
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'YOUR DIGITAL DEBIT CARD',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
              const SizedBox(height: 16),
              FutureBuilder<CardModel>(
                future: cardFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final card = snapshot.data!;
return Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Stack(
      children: [
        AnimatedBuilder(
          animation: _blurAnimation,
          builder: (context, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 240,
                height: 340,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 1,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: _blurAnimation.value,
                    sigmaY: _blurAnimation.value,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "YOLO",
                              style: GoogleFonts.tourney(
                                color: Colors.red,
                                decorationStyle: TextDecorationStyle.wavy,
                                fontSize: 18,
                              ),
                            ),
                            Image.asset('assets/yesbank.png', height: 35),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Card Number Split in 4-digit chunks
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(4, (i) {
                            final start = i * 4;
                            final end = start + 4;
                            return Text(
                              card.cardNumber.substring(start, end),
                              style: GoogleFonts.orbitron(
                                color: Colors.white54,
                                fontSize: 20,
                                letterSpacing: 2.5,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 8),

                        // Expiry and CVV row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "cvv: ••••",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.date_range,
                                    size: 14, color: Colors.white70),
                                const SizedBox(width: 4),
                                Text(
                                  "exp: ${card.expiry}",
                                  style: GoogleFonts.orbitron(
                                  fontSize: 12,
                                  color: Colors.white70,
                                  //fontWeight: FontWeight.w500,
                                ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Copy Details
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: card.cardNumber));
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.copy,
                                  color: Colors.red, size: 16),
                              const SizedBox(width: 6),
                              Text(
                                "copy details",
                                style: GoogleFonts.orbitron(
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset('assets/rupay.png', height: 34),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
    const SizedBox(width: 12),

    // Freeze Icon Outside the Card
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: toggleFreeze,
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 1),
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.3),
            ),
            child: const Icon(Icons.ac_unit, color: Colors.white, size: 20),
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: toggleFreeze,
          child: Text(
            isFrozen ? "unfreeze" : "freeze",
            style: GoogleFonts.poppins(
              color: const Color(0xFFA90808),
              fontSize: 12,
            ),
          ),
        )
      ],
    ),
  ],
);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
