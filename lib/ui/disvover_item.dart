import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_fun/API/api.dart';
import 'package:food_fun/main.dart';
import 'package:food_fun/ui/discover.dart';

class DiscoverItem extends StatefulWidget {
  const DiscoverItem({Key? key}) : super(key: key);

  @override
  State<DiscoverItem> createState() => _DiscoverItemState();
}

class _DiscoverItemState extends State<DiscoverItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
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
                      "Discover",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
          Positioned(
              top: size.height * 0.15,
              left: 0,
              right: 0,
              child:FutureBuilder<Map<String,dynamic>?>(
                future: API.discoverItem(user!.id, toDiscoverID!),
                builder: (context, snapshot){
                if(snapshot.connectionState==ConnectionState.done){
                  if(snapshot.hasData){
                    return  Center(
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.8,
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
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width * 0.8,
                        height: size.height * 0.3,
                        child: Image.network(snapshot.data!["URL"]),
                      ),
                      ListTile(
                        title: Text("Name"),
                        subtitle: Text(snapshot.data!["name"]),
                      ),
                      ListTile(
                        title: Text("Benefits"),
                        subtitle: Text(
                          snapshot.data!["content"]
                        )
                      ),
                    ],
                  ),
                ),
              );
                  }
                }
                return Container(
                  decoration: BoxDecoration(
                                      color: Colors.white,

                    borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/no data.svg"),
                      const Text("No Data Found")
                    ],
                  ),
                );
              },))
        ],
      )),
    );
  }
}
