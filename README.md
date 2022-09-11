# Skateboard Rental - Flutter Demo

Pretty Skateboard Rental App made with Flutter. Using Animation Controller and nested Animated Widgets.
Inspired in Outcrowd's design "Up. - Design for Mobile App" [link](https://dribbble.com/shots/15083025-Up-Design-for-Mobile-App).
The full video in my Youtube channel [link]() and my Flutter Demos App video list [link](https://www.youtube.com/playlist?list=PL29yTdfAdnEfQ1U0hRkFxqD-ei2ux8-Hk)
- Animation Controller.
- AnimatedContainer.
- AnimatedPositioned.
- PageView.builder.
- PageController.
- AnimatedOpacity.
- RichText.
- SmoothPageIndicator.
- Opacity.
- AnimatedCheck.
- Transform. 
- Transform: Matrix4.identity().


##Rotate and Perspective Transformations
```
Transform(alignment: Alignment.center,
          transform: Matrix4.identity()
                     ..rotateY(isCheckOut
                                ? math.pi
                                : math.pi * controller.value)
                     ..setEntry(3, 2, 0.001)
                      ..scale(isClickOnTable || isCheckOut
                                ? 1.0
                                : 0.5 + 0.5 * controller.value), 
```

##Graphical resource
- FlatIcon [link](https://www.flaticon.com/)
- PNGWing [link](https://www.pngwing.com/)

##Useful info: Change launch icon
- AppIcon [link](https://appicon.co/)
- Tutorial for change the Launch Icon [link](https://www.geeksforgeeks.org/flutter-changing-app-icon/)

## Getting Started

**Packages used:**
- page_transition: ^2.0.9 [link](https://pub.dev/packages/page_transition) 
- google_fonts: ^3.0.1 [link](https://pub.dev/packages/google_fonts)
- smooth_page_indicator: ^1.0.0+2 [link](https://pub.dev/packages/smooth_page_indicator)
- animated_text_kit: ^4.2.2 [link](https://pub.dev/packages/animated_text_kit)
- animated_check: ^1.0.5 [link](https://pub.dev/packages/animated_check)


## GIF
<p align="center">
<img src="screenshots/Animation.gif" height="700">
</p>

## Screenshots
<p align="center">
<img src="screenshots\Screenshot_1662936615.png" height="700">
<img src="screenshots\Screenshot_1662936654.png" height="700">
<img src="screenshots\Screenshot_1662936627.png" height="700">
<img src="screenshots\Screenshot_1662936665.png" height="700">
</p>


