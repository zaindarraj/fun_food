import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_fun/API/api.dart';
import 'package:food_fun/main.dart';

class ChildServings extends StatefulWidget {
  const ChildServings({Key? key}) : super(key: key);

  @override
  State<ChildServings> createState() => _ChildServingsState();
}

class _ChildServingsState extends State<ChildServings> {
  String seacrhFilter = "all";
  TextEditingController num = TextEditingController();
  showAlertDialog(BuildContext context, String serving, String url) async {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () async {
        if (num.text.isNotEmpty) {
          await API.add_serving(
              user!.id, serving, num.text, url);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("DONE")));
          Navigator.pop(context);
        }
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("CANCEL"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Number of servings : "),
      content: TextField(
        controller: num,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          label: Text("Num"),
        ),
      ),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
              child: Container(
            padding: EdgeInsets.all(5),
            height: size.height * .1,
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                Text(
                  "My Servings",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
          )),
          Positioned(
            top: size.height * 0.15,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white.withOpacity(0.5),
              height: size.height * 0.1,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    maxRadius: 30,
                    minRadius: 30,
                    backgroundColor: Colors.white,
                    child: TextButton(
                        onPressed: () {
                          seacrhFilter = "all";
                          setState(() {});
                        },
                        child: Text("All")),
                  ),
                  CircleAvatar(
                    maxRadius: 30,
                    minRadius: 30,
                    backgroundColor: Colors.white,
                    child: TextButton(
                        onPressed: () {
                          seacrhFilter = "fruits";
                          setState(() {});
                        },
                        child: Text("Fruits")),
                  ),
                  CircleAvatar(
                    maxRadius: 30,
                    minRadius: 30,
                    backgroundColor: Colors.white,
                    child: TextButton(
                        onPressed: () {
                          seacrhFilter = "vegetables";
                          setState(() {});
                        },
                        child: Text("Veges")),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
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
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white),
                  width: size.width * 0.9,
                  height: size.height * 0.7,
                  child: seacrhFilter == "all"
                      ? GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          children: [
                              Container(
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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.asset(
                                          "assets/tomato.jpg",
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text("Tomato"),
                                            IconButton(
                                                onPressed: () async {
                                                  showAlertDialog(
                                                    context,
                                                    "tomato",
                                                    "assets/tomato.jpg"
                                                  );
                                                },
                                                icon: const Icon(Icons.add))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.asset(
                                          "assets/apple.png",
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text("apple"),
                                            IconButton(
                                                onPressed: () async {
                                                 showAlertDialog(
                                                    context,
                                                    "apple",
"assets/apple.png"                                                    

                                                  );
                                               
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content:
                                                              Text("DONE")));
                                                },
                                                icon: Icon(Icons.add))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ])
                      : (seacrhFilter == "fruits")
                          ? GridView(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: EdgeInsets.all(5),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: size.width,
                                          height: size.height,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Image.asset(
                                              "assets/apple.png",
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
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20)),
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                            alignment: Alignment.center,
                                            width: size.width,
                                            height: size.height * 0.05,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text("apple"),
                                                IconButton(
                                                    onPressed: () async {
                                                      showAlertDialog(context, "apple",  "assets/apple.png");
                                                      await API.add_serving(
                                                          user!.id,
                                                          "apple",
                                                          num.text,
                                                          "assets/apple.png");
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                                  content: Text(
                                                                      "DONE")));
                                                    },
                                                    icon: Icon(Icons.add))
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ])
                          : GridView(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: EdgeInsets.all(5),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: size.width,
                                          height: size.height,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Image.asset(
                                              "assets/tomato.jpg",
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
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20)),
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                            alignment: Alignment.center,
                                            width: size.width,
                                            height: size.height * 0.05,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text("Tomato"),
                                                IconButton(
                                                    onPressed: () async {
                                                      showAlertDialog(context, "tomato", "assets/tomato.jpg");
                                                    
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                                  content: Text(
                                                                      "DONE")));
                                                    },
                                                    icon: Icon(Icons.add))
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ])))
        ],
      ),
    );
  }
}
