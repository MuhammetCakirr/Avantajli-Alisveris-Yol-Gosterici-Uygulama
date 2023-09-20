


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
  
  // This widget is the root of your application.
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



 

  /*Future<void> fetchData() async {
  final response = await http.get(
    Uri.parse('https://www.akakce.com/arama/?q=iphone+13'),
  );

  if (response.statusCode == 200) {
    print("VERİ ÇEKME BAŞARILI");
    // Yanıtı işleyin ve verileri çıkarın
    final responseBody = response.body;
    print(responseBody);
    final document = htmlParser.parse(responseBody);
    final priceElements = document.querySelectorAll('.product-price');
    for (final priceElement in priceElements) {
      final price = priceElement.text;
      print('Ürün Fiyatı: $price');
    }
    }
    
   else {
    // Yanıt alınamadı veya başarısız oldu
    throw Exception('Yanıt alınamadı, durum kodu: ${response.statusCode}');
  }
}*/

