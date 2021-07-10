import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoom_clone/constants/colors.dart';
import 'package:zoom_clone/constants/routes.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int _current = 0;

  final List<String> imgList = ['onBoard1.svg', 'onBoard2.svg', 'onBoard3.svg'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (context) {
            final double height = MediaQuery.of(context).size.height;
            return Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                      height: height,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      autoPlay: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                  items: imgList
                      .map(
                        (item) => Container(
                          color: appPurple,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    (MediaQuery.of(context).size.height) / 2,
                                width: double.infinity,
                                child: SvgPicture.asset(
                                  'assets/images/$item',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    constraints: BoxConstraints(
                                        minHeight: 0,
                                        maxHeight: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                            4),
                                    child: Text(
                                      "Title  ",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    constraints: BoxConstraints(
                                        minHeight: 0,
                                        maxHeight: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                            4),
                                    child: Text(
                                      "Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
                _current == (imgList.length - 1)
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.arrow_forward_ios,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(LOGIN_SCREEN);
                          },
                        ),
                      )
                    : SizedBox(),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: imgList.asMap().entries.map((entry) {
                        return GestureDetector(
                          child: Container(
                            width: _current == entry.key ? 30.0 : 25.0,
                            height: 6,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                //shape: BoxShape.circle,
                                color: Colors.black.withOpacity(
                                    _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
