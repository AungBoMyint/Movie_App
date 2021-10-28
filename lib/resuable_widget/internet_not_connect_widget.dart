import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InternetNotConnectWidget extends StatelessWidget {
  const InternetNotConnectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 200,
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: Icon(
              FontAwesomeIcons.exclamationTriangle,
              color: Colors.red,
            ),
            content: Text(
              "Connect The Internet.",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
