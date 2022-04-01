import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_fun/API/api.dart';
import 'package:food_fun/main.dart';
import 'package:food_fun/ui/parent_dashboard.dart';
import 'package:graphic/graphic.dart';

class Tracker extends StatefulWidget {
  const Tracker({Key? key}) : super(key: key);

  @override
  State<Tracker> createState() => _TrackerState();
}



class _TrackerState extends State<Tracker> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
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
            ],
          ),
          Positioned(
              top: 0,
              child: SafeArea(
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back)),
                       const Text(
                          "Servings Tracker",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              )),
          FutureBuilder<List<Map<String,dynamic>>?>(
            future: API.servings(user!.id, selectedDate.day.toString(), selectedDate.month.toString(), selectedDate.year.toString()),
            builder: (context, snapshot) {
            
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Container(
                  width: size.width,
                  height: size.height * 0.7,
                  padding: EdgeInsets.all(10),
                  child: Chart(
                    data: snapshot.data!,
                    variables: {
                      'serving': Variable(
                        accessor: (Map map) => map['serving'] as String,
                      ),
                      'num': Variable(
                        accessor: (Map map) => map['num'] as num,
                      ),
                    },
                    elements: [IntervalElement()],
                    axes: [
                      Defaults.horizontalAxis,
                      Defaults.verticalAxis,
                    ],
                  ),
                );
              }
            }
             return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/no data.svg"),
                      Text("No Data Found")
                    ],
                  );
          })
        ],
      ),
    );
  }
}
