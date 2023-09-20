


import 'package:enucuzurun/controller/Web_services.dart';
import 'package:enucuzurun/ui/SplashScreen_Page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
//import 'package:http/http.dart' as http;
//import 'package:html/parser.dart' as htmlParser;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    Get.put(WebService());
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: const SplashScreen(),
    );
  }
}


