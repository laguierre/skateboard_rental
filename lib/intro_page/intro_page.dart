import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:math' as math;

import '../home_page/home_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _position;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3500));
    _position = Tween<double>(begin: 0.5, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0, 1))
          ..addListener(() {
            setState(() {});
          }));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Flexible(
            flex: 3,
            child: Stack(
              children: [
                Positioned(
                  top: -430 - (50 * _position.value),
                  right: 40 + 20 * _position.value,
                  child: Transform.scale(
                    scale: 0.7,
                    child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationZ(math.pi * 0.22),
                        child: Image.asset('lib/assets/images/1.png')),
                  ),
                ),
                Positioned(
                  top: -340 - (50 * _position.value),
                  right: -150 + 50 * _position.value,
                  child: Transform.scale(
                    scale: 0.65,
                    child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationZ(math.pi * 0.22),
                        child: Image.asset('lib/assets/images/2.png')),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Container(
              alignment: Alignment.center,
              height: size.height * 0.15,
              decoration: BoxDecoration(
                color: const Color(0xFF012FBD),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text('Up!',
                  style: GoogleFonts.mulish(
                      color: Colors.grey.shade300,
                      fontSize: 44,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Snowboard\nand Ski rental',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                          fontSize: 44, fontWeight: FontWeight.bold)),
                  Text('Largest rental service in New York',
                      style: GoogleFonts.mulish(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        backgroundColor: const Color(0xFF012FBD),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 16),
                        textStyle: GoogleFonts.mulish(
                            color: Colors.grey.shade300,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    child: const Text('Get Started'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const HomePage(),
                              type: PageTransitionType.fade));
                    },
                  )
                ],
              ))
        ],
      ),
    );
  }
}
