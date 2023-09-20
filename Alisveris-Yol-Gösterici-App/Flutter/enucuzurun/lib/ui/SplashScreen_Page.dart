import 'dart:convert';

import 'package:enucuzurun/controller/Web_services.dart';
import 'package:enucuzurun/models/ikiFiyatliUrun.dart';
import 'package:enucuzurun/models/tekFiyatliUrun.dart';
import 'package:enucuzurun/ui/Home_Page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  final WebService webService = Get.find<WebService>();
  //final List<tekFiyatliUrun> IndirimliUrunlerList = [];
  //final List<ikiFiyatliUrun> TakipUrunlerList = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    webService.KategorileriDoldur();
    webService.fetchData().then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(
       
          ),
        ),
      );
    });
  
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veri Çekme Örneği'),
      ),
      body: Center(
        child: CircularProgressIndicator()
      ),
    );
  }
}

