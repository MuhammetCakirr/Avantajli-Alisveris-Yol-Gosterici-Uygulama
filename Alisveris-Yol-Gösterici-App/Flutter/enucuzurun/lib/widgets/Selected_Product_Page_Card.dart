import 'package:enucuzurun/controller/Web_services.dart';
import 'package:enucuzurun/models/magaza.dart';
import 'package:enucuzurun/ui/Product_Detail_Page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SelectedProductPageCard extends StatefulWidget {
  final String id;
  final String adi;
  final String magaza1;
  final String magaza2;
  final String Fiyat1;
  final String Fiyat2;
  final String FotografYolu;
  final String incelebutonu;
 
  const SelectedProductPageCard(
      {super.key,
      required this.Fiyat1,
      required this.Fiyat2,
      required this.FotografYolu,
      required this.adi,
      required this.id,
      required this.incelebutonu,
      required this.magaza1,
      required this.magaza2});

  @override
  State<SelectedProductPageCard> createState() => _SelectedProductPageCardState();
}

class _SelectedProductPageCardState extends State<SelectedProductPageCard> {

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
    return GestureDetector(
      onTap: () async{
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
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child:Image.network("https:"+widget.FotografYolu,
                      width: double.infinity,
                      height: 95.0,) 
              ),
              SizedBox(height: 5.0),
              Text(
                kisaad,
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 5.0),
              Text(
                widget.magaza1,
                style: TextStyle(fontSize: 8.0, color: Colors.blue),
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Text(
                    widget.Fiyat1.toString(),
                    style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'EN UCUZ',
                    style: TextStyle(
                        fontSize: 9.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Text(
                widget.magaza2,
                style: TextStyle(fontSize: 8.0, color: Colors.blue),
              ),
              SizedBox(height: 5.0),
              Text(
                widget.Fiyat2.toString(),
                style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.blue),
                      borderRadius: BorderRadius.circular(20.0)),
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: 20,
                  child: Text("Tümünü İncele",style: TextStyle(color: Colors.black, fontSize: 13,fontWeight: FontWeight.bold))
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}