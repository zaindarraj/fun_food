import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_fun/API/api.dart';
import 'package:food_fun/main.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  State<Discover> createState() => _DiscoverState();
}

String? toDiscoverID;

class _DiscoverState extends State<Discover> {
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
      SafeArea(
        child: Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              height: size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      )),
                  const Text(
                    "Discover All Added Fruits and Vegetables",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
      ),
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: FutureBuilder<List<Map<String, dynamic>>?>(
            future: API.discover(user!.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(
                            0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white),
                width: size.width * 0.9,
                height: size.height * 0.7,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          toDiscoverID = snapshot.data![index]["id"];
                          Navigator.pushNamed(context, "discover_item");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.all(5),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: size.width,
                                height: size.height,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    snapshot.data![index]["URL"],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                  alignment: Alignment.center,
                                  width: size.width,
                                  height: size.height * 0.05,
                                  child: Text(snapshot.data![index]["name"])
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              );
                }
              }
              
              return Container(
                height: size.height*0.8,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/no data.svg"),
                    Text("No Data Found")
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
