import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LightSwitch extends StatefulWidget {
  const LightSwitch({Key? key}) : super(key: key);

  @override
  State<LightSwitch> createState() => _LightSwitchState();
}

class _LightSwitchState extends State<LightSwitch> {
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
            activeColor: Color.fromARGB(255, 245, 245, 91),
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
