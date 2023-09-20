import 'package:enucuzurun/models/ikiFiyatliUrun.dart';
import 'package:enucuzurun/ui/Home_Page.dart';
import 'package:enucuzurun/widgets/Selected_Product_Page_Card.dart';
import 'package:enucuzurun/widgets/Selected__Product_Card.dart';
import 'package:flutter/material.dart';

class SelectedProducts extends StatefulWidget {
  final List<ikiFiyatliUrun> urunler;
  const SelectedProducts({super.key, required this.urunler});

  @override
  State<SelectedProducts> createState() => _SelectedProductsState();
}

class _SelectedProductsState extends State<SelectedProducts> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.15,
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                    },
                    icon: Icon(Icons.arrow_back_ios_new)),
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                child: TextField(
                  textAlign: TextAlign.justify,
                  decoration: InputDecoration(
                      hintText: "Ürün Ara",
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 15.0),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),    
          SizedBox(
            height: 10,
          ),
          Container(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Sütun sayısı (2 tane ürün her satırda)
                childAspectRatio: 0.7, // Genişlik ve yükseklik oranı
              ),
              itemCount: widget.urunler.length,
              itemBuilder: (context, index) {
                return SelectedProductPageCard(
                  Fiyat1: widget.urunler[index].birincimagazafiyat,
                  Fiyat2: widget.urunler[index].ikincimagazafiyat,
                  FotografYolu: widget.urunler[index].fotografYolu,
                  adi: widget.urunler[index].adi,
                  id: widget.urunler[index].id,
                  incelebutonu: widget.urunler[index].incelebutonu,
                  magaza1: widget.urunler[index].birincimagaza,
                  magaza2: widget.urunler[index].ikincimagaza,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
