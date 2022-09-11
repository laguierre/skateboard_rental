import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skateboard_rental/details_page/details_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:math' as math;
import '../data/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late PageController pageController;
  bool isSnowboard = true;
  bool trigger = false;
  double currentPage = 0;
  double pageValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    pageController =
        PageController(viewportFraction: 0.43, initialPage: items.length);

    pageController.addListener(() {
      setState(() {
        for (pageValue = pageController.page!; pageValue > 1;) {
          (pageValue--);
        }
        currentPage = pageController.page!;
      });
    });
    Future.delayed(const Duration(milliseconds: 50), () {
      pageController.animateToPage(0,
          duration: const Duration(milliseconds: 2000),
          curve: const Interval(0, 1));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: CustomFieldText(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 30, 25, 30),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      backgroundColor:
                          isSnowboard ? kPrimaryColor : Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                    ),
                    child: Text('Snowboard',
                        style: GoogleFonts.mulish(
                            color: isSnowboard
                                ? Colors.grey.shade300
                                : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      setState(() {
                        isSnowboard = true;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    backgroundColor:
                        isSnowboard ? Colors.white : const Color(0xFF012FBD),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                  ),
                  child: Text('Ski',
                      style: GoogleFonts.mulish(
                          color: !isSnowboard
                              ? Colors.grey.shade300
                              : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    setState(() {
                      isSnowboard = false;
                    });
                  },
                ))
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
                onPageChanged: (index) {
                  debugPrint(index.toString());
                  setState(() {
                    trigger = true;
                  });
                },
                physics: const BouncingScrollPhysics(),
                padEnds: false,
                controller: pageController,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final result = currentPage - index;
                  double value = (-1 * result * result + 1).clamp(0, 1);
                  return Container(
                    width: double.infinity,
                    margin: index == result && currentPage > 0.6
                        ? EdgeInsets.symmetric(vertical: 20 * value)
                        : EdgeInsets.symmetric(vertical: 20 + 50 * value),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          width: 3,
                          color: Colors.grey,
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: DetailsPage(index: index),
                                    type: PageTransitionType.fade));
                          },
                          child: Transform.rotate(
                              angle: -math.pi * 0.05 * value,
                              child: Hero(
                                tag: items[index].image,
                                child: Image.asset(
                                  items[index].image,
                                  fit: BoxFit.contain,
                                ),
                              )),
                        )),
                      ],
                    ),
                  );
                }),
          ),
          const SizedBox(height: 10),
          SmoothPageIndicator(
              count: items.length,
              controller: pageController,
              effect: const ScrollingDotsEffect(
                  spacing: 10,
                  activeDotScale: 1.3,
                  dotHeight: 14,
                  dotWidth: 14,
                  activeDotColor: kPrimaryColor), // your preferred effect
              onDotClicked: (index) {}),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class CustomFieldText extends StatelessWidget {
  const CustomFieldText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.search,
              color: Colors.grey,
              size: 20,
            ),
          ),
          Expanded(
            child: TextField(
              enabled: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                isDense: true,
              ),
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
