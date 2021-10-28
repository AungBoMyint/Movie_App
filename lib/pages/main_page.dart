import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/resuable_widget/internet_not_connect_widget.dart';

import 'home_page.dart';

class MainPage extends StatelessWidget {
  static final _conn = Connectivity();
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: _conn.onConnectivityChanged,
        builder: (context, status) {
          //If Connectivity Status has Data
          if (status.hasData) {
            final data = status.data;

            //Check If Connection is none whe show WarningWidget or show HomePage.
            return data == ConnectivityResult.none
                ? const InternetNotConnectWidget()
                : data == ConnectivityResult.mobile
                    ? const HomePage()
                    : data == ConnectivityResult.wifi
                        ? const HomePage()
                        : const CircularProgressIndicator();
          }
          //Default Widget
          return Scaffold(
              body: Center(
                  child: Container(
                      width: 50,
                      height: 50,
                      child: const CircularProgressIndicator())));
        });
  }
}
