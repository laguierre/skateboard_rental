import 'package:animated_check/animated_check.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controllerCheck;
  late Animation<double> animationCheck;

  bool isTrigger = false;
  bool isTextAppear = false;
  bool isFinishInitial = false;
  static const kAnimatedContainer = 800;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        upperBound: 3.5,
        vsync: this,
        duration: const Duration(milliseconds: 2000))
      ..addListener(() {
        setState(() {
          if (controller.value > 1) {
            isTrigger = true;
            if (controller.isCompleted) {
              isTrigger = false;
              isFinishInitial = true;
            }
          }
        });
      });
    controllerCheck = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animationCheck = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controllerCheck, curve: Curves.easeInOutCirc));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    controllerCheck.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFFA809),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: (controller.value).clamp(0, 1),
            child: Transform.scale(
              scale: (1 + (1 - controller.value.clamp(0, 1))),
              child: Stack(
                children: [
                  Positioned(
                      top: 250,
                      left: 10,
                      right: 10,
                      child: Image.asset('lib/assets/images/snow.png')),
                  Positioned(
                      bottom: -10,
                      child: Image.asset('lib/assets/images/montain.png')),
                ],
              ),
            ),
          ),
          isTrigger && !isFinishInitial
              ? Positioned(
                  left: 0,
                  right: 0,
                  top: 80,
                  child: Center(
                    child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      repeatForever: false,
                      animatedTexts: [
                        TyperAnimatedText(
                          'Completed',
                          textStyle: GoogleFonts.mulish(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          Positioned(
            left: 0,
            right: 0,
            top: 150 - 30 * (2 - controller.value.clamp(0, 2)),
            child: Center(
              child: Opacity(
                opacity: !isFinishInitial
                    ? (controller.value - 1).clamp(0, 1)
                    : (3 - controller.value).clamp(0, 1),
                child: Text(
                  'Get ready to start your ride!',
                  style: GoogleFonts.mulish(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
              duration: const Duration(milliseconds: kAnimatedContainer),
              top: !isFinishInitial ? 0 : 130,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: kAnimatedContainer),
                opacity: isFinishInitial ? 1 : 0,
                child: AnimatedContainer(
                  onEnd: () {
                    controllerCheck.forward();
                  },
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: kAnimatedContainer),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: !isFinishInitial ? size.width : 70,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: AnimatedCheck(
                    progress: animationCheck,
                    size: 60,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
