import 'package:flutter/material.dart';
import 'package:flutter_flow_menu/flow_menu.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: const FlowMenu(
        menuItems: [
          Icons.ac_unit,
          Icons.face,
          Icons.h_mobiledata,
          Icons.qr_code,
          Icons.rtt,
          Icons.menu,
        ],
      )),
    );
  }
}
