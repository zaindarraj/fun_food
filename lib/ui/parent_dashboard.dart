import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_fun/API/api.dart';
import 'package:food_fun/main.dart';

DateTime selectedDate = DateTime.now();

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({Key? key}) : super(key: key);

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.child_care_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "child_screen");
          }),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.3,
                child: SvgPicture.asset(
                  "assets/top parent.svg",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: size.width,
                height: size.height * 0.3,
                child: SvgPicture.asset(
                  "assets/bottom  parent.svg",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            child: SafeArea(
              child: SizedBox(
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "servings");
                              },
                              icon: const Icon(
                                Icons.message_outlined,
                                color: Colors.redAccent,
                                size: 40,
                              )),
                          FutureBuilder<String>(
                              future:
                                  API.notificationNumber(user?.id as String),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    return CircleAvatar(
                                      maxRadius: 10,
                                      child: Text(snapshot.data!),
                                    );
                                  }
                                }
                                return const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  maxRadius: 10,
                                  child: Text("0"),
                                );
                              })
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "profile");
                          },
                          icon: const Icon(
                            Icons.person_pin_circle,
                            color: Color.fromARGB(255, 255, 211, 53),
                            size: 40,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: size.height * 0.3,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Categories",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.4,
                      child: GridView(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "fruits");
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: const DecorationImage(
                                      image: AssetImage("assets/fruits.jpg")),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                width: size.width * 0.4,
                                height: size.height * 0.2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(186, 158, 158, 158),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.all(8),
                                  child: const Text(
                                    "Fruits",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "vegetables");
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: const DecorationImage(
                                      image:
                                          AssetImage("assets/vegetabled.jpg")),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                width: size.width * 0.4,
                                height: size.height * 0.2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          186, 158, 158, 158),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.all(8),
                                  child: const Text(
                                    "Vegetables",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "all");
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: const DecorationImage(
                                      image: AssetImage("assets/all.webp")),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                width: size.width * 0.4,
                                height: size.height * 0.2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(186, 158, 158, 158),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.all(8),
                                  child: const Text(
                                    "All",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Track Your Child's Servings",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          await _selectDate(context).then((value) {
                            Navigator.pushNamed(context, "tracker");
                          });
                        },
                        child: Text("Choose Date"))
                  ]))
        ],
      ),
    );
  }
}
