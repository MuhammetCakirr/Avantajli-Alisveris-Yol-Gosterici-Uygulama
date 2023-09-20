import 'dart:convert';

import 'package:enucuzurun/controller/Web_services.dart';
import 'package:enucuzurun/models/magaza.dart';
import 'package:enucuzurun/ui/Product_Detail_Page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class DiscountProduct extends StatefulWidget {
  final String id;
  final String adi;
  final String Saticimagaza;
  final String indirimlifiyat;
  final String eskifiyat;
  final String FotografYolu;
  final String incelebutonu;
  final String son30;
  final String bugunbasladi;
  const DiscountProduct(
      {super.key,
      required this.FotografYolu,
      required this.Saticimagaza,
      required this.adi,
      required this.bugunbasladi,
      required this.eskifiyat,
      required this.id,
      required this.incelebutonu,
      required this.indirimlifiyat,
      required this.son30});

  @override
  State<DiscountProduct> createState() => _DiscountProductState();
}

class _DiscountProductState extends State<DiscountProduct> {
  List<Magaza> magazalar=[];
  final WebService webService = Get.find<WebService>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String kisaltilmisUrunAdi(String urunAdi, int kelimeSiniri) {
    List<String> kelimeler = urunAdi.split(' ');
    if (kelimeler.length > kelimeSiniri) {
      kelimeler = kelimeler.sublist(0, kelimeSiniri);
      kelimeler.add('...');
    }
    return kelimeler.join(' ');
  }
  @override
  Widget build(BuildContext context) {
    var kisaad = kisaltilmisUrunAdi(widget.adi, 11);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          children: [
            Container(
              width: 130.0,
              height: 150.0,
              child: Image.network(
                widget.FotografYolu,
                width: double.infinity,
                height: 95.0,
              ),
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 180,
                  child: Text(
                    kisaad,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  widget.Saticimagaza,
                  style: TextStyle(fontSize: 11, color: Colors.blue),
                ),
                SizedBox(height: 5.0),
                Row(
                  children: [
                    Text(
                      widget.indirimlifiyat,
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.eskifiyat,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_circle_down_rounded,
                        color: Colors.green,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 110,
                        child: Text(
                          widget.son30,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.date_range_rounded,
                        color: Colors.red,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 110,
                        child: Text(
                          widget.bugunbasladi == "Evet" ? "İndirim Bugün Başladı" : "",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () async {
                        await webService.sendRequest(widget.id);
                        magazalar=webService.magazalar;
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ProductDetail(
                              magazalarr: magazalar,
                            ),
                          ),
                        );
                      },
                      child: Text(widget.incelebutonu),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 67, 135, 167)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
