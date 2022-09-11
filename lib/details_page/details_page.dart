import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skateboard_rental/checkout_page/checkout_page.dart';
import 'dart:math' as math;
import '../data/data.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isFront = true;
  bool isTrigger = false;
  bool isClickOnTable = false;
  bool isCheckOut = false;

  @override
  void initState() {
    controller = AnimationController(
        lowerBound: -1.0,
        upperBound: 1.0,
        vsync: this,
        duration: const Duration(milliseconds: 1000))
      ..addListener(() {
        setState(() {
          controller.value.abs() >= 0.5 ? isFront = true : isFront = false;
          if(controller.isCompleted && isCheckOut){
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: const CheckOutPage(),
                    type: PageTransitionType.fade));
          }
        });
      });
    setState(() {
      isTrigger = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      isTrigger = false;
      controller.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double offSetTable = -60.0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              padding: const EdgeInsets.only(right: 25),
              onPressed: () {},
              icon: Image.asset(
                'lib/assets/icons/4point.png',
                height: 25,
              ))
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 0, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(items[widget.index].brand,
                    style: GoogleFonts.mulish(
                        fontSize: 55, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),
                RichText(
                  text: TextSpan(
                    text: 'Model: ',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700),
                    children: <InlineSpan>[
                      TextSpan(
                          text: items[widget.index].model,
                          style: const TextStyle(color: Colors.black)),
                      const TextSpan(
                          text: '\nCollection: ',
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: items[widget.index].collection,
                          style: const TextStyle(color: Colors.black)),
                      const WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: SizedBox(height: 30)),
                      const TextSpan(
                          text: '\nHeight: ',
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: '${items[widget.index].height} cm',
                          style: const TextStyle(color: Colors.black)),
                      const WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: SizedBox(height: 30)),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    items[widget.index].isAvailability
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.do_not_disturb_on_rounded,
                            color: Colors.red),
                    const SizedBox(width: 10),
                    Text(
                        items[widget.index].isAvailability
                            ? 'Availability'
                            : 'Not Availability',
                        style: GoogleFonts.mulish(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ],
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(
                    text: '\$',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                    children: <InlineSpan>[
                      TextSpan(
                          text: items[widget.index].price.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 55)),
                      const TextSpan(
                          text: '\nDate: ',
                          style: TextStyle(color: Colors.grey)),
                      const TextSpan(
                          text: '19 JAN',
                          style: TextStyle(color: Colors.black)),
                      const WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: SizedBox(height: 35)),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
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
                  child: const Text('Check out'),
                  onPressed: () {
                    setState(() {
                      setState(() {
                        isCheckOut = true;
                        controller.duration = const Duration(milliseconds: 2000);
                        controller.forward(from: 0);
                      });
                    });
                  },
                )
              ],
            ),
          ),
          Stack(
            children: [
              Positioned(
                  top: 10,
                  bottom: 20,
                  right: isCheckOut
                      ? offSetTable - 150 * controller.value
                      : isClickOnTable
                          ? offSetTable
                          : 90 - 150 * controller.value,
                  child: GestureDetector(
                    onTap: () {
                      isClickOnTable = true;
                      controller.isCompleted
                          ? controller.reverse()
                          : controller.forward();
                    },
                    child: Opacity(
                      opacity: isClickOnTable || isCheckOut
                          ? 1.0
                          : controller.value > 0
                              ? (controller.value.abs() + 0.5).clamp(0, 1)
                              : 0.5,
                      child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..rotateY(isCheckOut
                                ? math.pi
                                : math.pi * controller.value)
                            ..setEntry(3, 2, 0.001)
                            ..scale(isClickOnTable || isCheckOut
                                ? 1.0
                                : 0.5 + 0.5 * controller.value), // perspective
                          child: isFront || isCheckOut
                              ? Hero(
                                  tag: items[widget.index].image,
                                  child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 100),
                                      opacity: isTrigger ? 0 : 1,
                                      child: Image.asset(
                                          items[widget.index].image)))
                              : Image.asset('lib/assets/images/3.png')),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
