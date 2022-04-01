import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChildScreen extends StatefulWidget {
  const ChildScreen({Key? key}) : super(key: key);

  @override
  State<ChildScreen> createState() => _ChildScreenState();
}

class _ChildScreenState extends State<ChildScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: size.height * 0.4,
                  width: size.width,
                  child: SvgPicture.asset(
                    "assets/upperBackground.svg",
                    fit: BoxFit.fill,
                  )),
              SizedBox(
                  height: size.height * 0.4,
                  width: size.width,
                  child: SvgPicture.asset(
                    "assets/bottomBackground.svg",
                    fit: BoxFit.fill,
                  ))
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.all(10),
                height: size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Home Page",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "parent_dashboard");
                        },
                        icon: const Icon(
                          Icons.person_pin_circle_rounded,
                          size: 30,
                        ))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.15,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                width: size.width * 0.9,
                height: size.height * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Fun Food Where Learning Becomes Fun",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "child_servings");
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        height: size.height * 0.1,
                        width: size.width * 0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("My Servings"),
                            SizedBox(
                                width: size.width * 0.3,
                                height: size.height * 0.1,
                                child: SvgPicture.asset(
                                  "assets/apple.svg",
                                  fit: BoxFit.contain,
                                  width: size.width * 0.3,
                                  height: size.height * 0.1,
                                )),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("discover");
                      },
                      child: SizedBox(
                        height: size.height * 0.1,
                        width: size.width * 0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Discover"),
                            SizedBox(
                                width: size.width * 0.3,
                                height: size.height * 0.1,
                                child: Image.asset(
                                  "assets/discover.png",
                                  fit: BoxFit.contain,
                                  width: size.width * 0.3,
                                  height: size.height * 0.1,
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                      width: size.width * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Quiz"),
                          SizedBox(
                              width: size.width * 0.3,
                              height: size.height * 0.1,
                              child: Image.asset(
                                "assets/quiz.png",
                                fit: BoxFit.contain,
                                width: size.width * 0.3,
                                height: size.height * 0.1,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
