import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class OnBoardScreen extends StatelessWidget {
  final page = [
    PageViewModel(
      pageColor: Colors.blue[50],
      bubbleBackgroundColor: Colors.grey[800],
      title: Text(
        'Welcome',
      ),
      body: Text(
        'Welcome to Zoom,\n free video call app',
      ),
      mainImage: SvgPicture.asset("assets/images/onBoard1.svg"),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
      bodyTextStyle: TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
      ),
    ),
    PageViewModel(
      pageColor: Colors.indigo[50],
      bubbleBackgroundColor: Colors.grey[800],
      title: Text('Join or Start Meetings'),
      body: Text(
        'Easy to use, join\nor start a meeting.',
      ),
      mainImage: SvgPicture.asset("assets/images/onBoard2.svg"),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
      bodyTextStyle: TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
      ),
    ),
    PageViewModel(
      pageColor: Colors.purple[50],
      bubbleBackgroundColor: Colors.grey[800],
      title: Text('Chat during meetings'),
      body: Text(
        'Chat with people\n in the meeting.',
      ),
      mainImage: SvgPicture.asset("assets/images/onBoard3.svg"),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
      bodyTextStyle: TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IntroViewsFlutter(
          page,
          onTapDoneButton: () {
            Navigator.of(context).pushReplacementNamed('/login');
          },
          onTapSkipButton: () {
            Navigator.of(context).pushReplacementNamed('/login');
          },
          skipText: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.all(10),
            child: Text(
              "Skip",
              style: TextStyle(color: Colors.black),
            ),
          ),
          doneText: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.all(10),
            child: Text(
              "Done",
              style: TextStyle(color: Colors.black),
            ),
          ),
          showSkipButton: true,
        ),
      ),
    );
  }
}
