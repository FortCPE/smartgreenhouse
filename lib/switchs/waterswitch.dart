import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class WaterSwitch extends StatefulWidget {
  const WaterSwitch({Key? key}) : super(key: key);

  @override
  State<WaterSwitch> createState() => _WaterSwitchState();
}

class _WaterSwitchState extends State<WaterSwitch> {
  bool isSwitched = true;
  var textValue = '';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = '';
      });
      print('Water Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = '';
      });
      print('Water Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Transform.scale(
          scale: 2,
          child: Switch(
            onChanged: toggleSwitch,
            value: isSwitched,
            activeColor: Colors.blueGrey,
            activeTrackColor: Colors.grey,
            inactiveThumbColor: Colors.black12,
            inactiveTrackColor: Colors.grey,
          )),
      Text(
        '$textValue',
        style: TextStyle(fontSize: 20),
      )
    ]);
  }
}
