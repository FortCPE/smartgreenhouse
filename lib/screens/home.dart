import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smartgreenhouse/screens/switch.dart';
import 'package:smartgreenhouse/switchs/lightswitch.dart';
import 'package:smartgreenhouse/switchs/waterswitch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hempster",
          style: TextStyle(
              color: Color.fromARGB(255, 53, 95, 65),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Center(
                  child: Column(
                children: [
                  Image.asset(
                    "assets/images/weed.png",
                    width: 200,
                    height: size.height * 0.4,
                  )
                ],
              )),
              Center(
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.4,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 5),
                            )
                          ]),
                      child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LightSwitch(),
                                  SizedBox(height: 5),
                                  Text(
                                    "แสงไฟ",
                                    style: TextStyle(
                                        fontFamily: "Prompt",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 0),
                                  Text(
                                    "2000 LUX",
                                    style: TextStyle(fontFamily: "Prompt"),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  WaterSwitch(),
                                  SizedBox(height: 5),
                                  Text(
                                    "รดน้ำ",
                                    style: TextStyle(
                                        fontFamily: "Prompt",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 0),
                                  Text(
                                    "2 liter",
                                    style: TextStyle(fontFamily: "Prompt"),
                                  )
                                ],
                              ),
                            ]),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Color.fromARGB(255, 75, 135, 92),
          selectedLabelStyle:
              TextStyle(fontFamily: "Prompt", fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontFamily: "Prompt"),
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "โรงเรือน",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop),
              label: "ร้านค้า",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: "การเงิน",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "โปรไฟล์",
            ),
          ]),
    );
  }
}
