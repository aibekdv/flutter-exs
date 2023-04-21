import 'package:flutter/material.dart';
import 'package:sabak_8_login_page/home/components/center_widget/center_widget.dart';
import 'login_page.dart';
import 'dart:math' as math;

class Home extends StatelessWidget {
  const Home({Key? key, required this.homeName, required this.homeEmail})
      : super(key: key);
  final String homeName;
  final String homeEmail;

  Widget topWiget(double screenWidth) {
    return Transform.rotate(
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.2 * screenWidth,
        height: 1.2 * screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: const LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [
              Color(0x007cbfcf),
              Color(0xb316bfc4),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomWidget(double screenWidth) {
    return Container(
      width: 1.2 * screenWidth,
      height: 1.2 * screenWidth,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(0.6, -1.1),
          end: Alignment.bottomCenter,
          colors: [
            Color(0xdb4be8cc),
            Color(0x005cdbcf),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -160,
            left: -30,
            child: topWiget(screenSize.width),
          ),
          Positioned(
              bottom: -80, left: -40, child: bottomWidget(screenSize.width)),
          CenterWidget(size: screenSize),
          Center(
            child: Text(
              "Student name: $homeName\nStudent email:$homeEmail",
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
