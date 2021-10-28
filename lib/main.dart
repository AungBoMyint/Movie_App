import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/provider/change_provider.dart';
import 'package:movie_app/provider/data_provider.dart';
import 'package:movie_app/route.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
  ///Status Bar Transparent
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChangeProvider()),
        Provider(create: (_) => DataProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteGenerator.mainPage,
          onGenerateRoute: RouteGenerator.generateRoute,
          theme: ThemeData.dark()),
    );
  }
}
