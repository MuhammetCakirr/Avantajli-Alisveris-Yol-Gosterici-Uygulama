import 'package:enucuzurun/controller/Web_services.dart';
import 'package:enucuzurun/models/ikiFiyatliUrun.dart';
import 'package:enucuzurun/models/kategori.dart';
import 'package:enucuzurun/models/magaza.dart';
import 'package:enucuzurun/models/tekFiyatliUrun.dart';
import 'package:enucuzurun/ui/All_Categories.dart';
import 'package:enucuzurun/ui/Selected_Product_Page.dart';
import 'package:enucuzurun/ui/SplashScreen_Page.dart';
import 'package:enucuzurun/widgets/Categories.dart';
import 'package:enucuzurun/widgets/Discount_product.dart';

import 'package:enucuzurun/widgets/Selected__Product_Card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomePage extends StatefulWidget {
  //List<tekFiyatliUrun>? IndirimliUrunlerList;
  //List<ikiFiyatliUrun>? TakipUrunlerList ;

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final WebService webService = Get.find<WebService>();
  List<tekFiyatliUrun>? IndirimliUrunlerList;
  List<ikiFiyatliUrun>? TakipUrunlerList;
  late TabController tabController;
  List<Magaza> magazaListesi = [];
  List<Kategori> kategoriListesi = [];
  List<Kategori> kategoriListesi2 = [];
  List<ikiFiyatliUrun> TakipUrunlerList2 = [];
  List<tekFiyatliUrun> IndirimliUrunlerList2 = [];
  TextEditingController _textEditingController = TextEditingController();
  List<ikiFiyatliUrun> SearchList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    kategoriListesi2=webService.kategoriler;
    kategoriListesi=kategoriListesi2.sublist(0,6);
    IndirimliUrunlerList = webService.IndirimliUrunlerList;
    TakipUrunlerList = webService.TakipUrunlerList;
    TakipUrunlerList2.addAll(TakipUrunlerList ?? []);
    IndirimliUrunlerList2.addAll(IndirimliUrunlerList ?? []);
    for (var urun in TakipUrunlerList!) {
      if (urun.adi.contains(
          "Dövme Makinesi, Tattoo Permanent Makeup Machine Import Swiss Motor Lip Eyeliner Microblading Eyebrow Makeup Machine (Color : Zwart)")) {
        TakipUrunlerList2.remove(urun);
      }
      if (urun.fotografYolu == "Bilinmiyor") {
        TakipUrunlerList2.remove(urun);
      }

      urun.fotografYolu.replaceAll(" ", "");
    }

    for (var urun in IndirimliUrunlerList!) {
      if (urun.fotografYolu == "Bilinmiyor") {
        TakipUrunlerList2.remove(urun);
      }

      urun.fotografYolu.replaceAll(" ", "");
    }

    tabController = TabController(length: 4, vsync: this);
   
   
  }
   @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
  void _handleSearch() async {
    String searchText = _textEditingController.text;
    
    searchText = searchText.replaceAll(' ', '%20');
    await webService.sendRequestsearch(searchText);
    SearchList=webService.SearchList;
    Navigator.push(
            context,
             MaterialPageRoute(
            builder: (context) => SelectedProducts(urunler: SearchList, ), 
    ),
             );
    print('Arama yapıldı: $searchText');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(right: 10, left: 10),
            height: 50,
            width: 300,
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
              controller:_textEditingController,
              onSubmitted: (text)
              {
                 _handleSearch(); 
              },
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
          Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                            Text(
                    "Popüler Kategoriler",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.stream,
                    color: Colors.red,
                    size: 25,
                  ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllCategories()));
                    },
                    child: Container(
                      child: Row(
                        children: [
                              Text(
                                      "Tümünü Gör",
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 8,
                ),
                itemCount: kategoriListesi.length,
                itemBuilder: (context, index) {
                  return Categories(
                    kategoriAd: kategoriListesi[index].adi,
                    kategoriImgUrl: kategoriListesi[index].fotografYolu,
                    url: kategoriListesi[index].url,
                  );
                },
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
Text(
                    "İndirimli Ürünler",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.notifications_rounded,
                    color: Colors.yellow,
                    size: 30,
                  ),
                    ],
                  ),
                    Padding(
                      padding: const EdgeInsets.only(right :8.0),
                      child: Container(
                        child: Row(
                          children: [
                                Text(
                                        "Kaydır",
                                        style: TextStyle(color: Colors.black, fontSize: 15),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                          ],
                        ),
                      ),
                    ),
                  
                ],
              )),
          Container(
            height: MediaQuery.of(context).size.height * 0.28,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: IndirimliUrunlerList2.map((urun) {
                  return DiscountProduct(
                    FotografYolu: urun.fotografYolu,
                    Saticimagaza: urun.Saticimagaza,
                    adi: urun.adi,
                    bugunbasladi: urun.bugunbasladi,
                    id: urun.id,
                    incelebutonu: urun.incelebutonu,
                    eskifiyat: urun.eskifiyat,
                    son30: urun.son30,
                    indirimlifiyat: urun.indirimlifiyat,
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10),
              child: Row(
                children: [
                  Text(
                    "En Çok Takip Edilen Ürünler",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.folder_special,
                    color: Colors.deepOrangeAccent,
                    size: 30,
                  ),
                ],
              )),
          Container(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Sütun sayısı (2 tane ürün her satırda)
                childAspectRatio: 0.7, // Genişlik ve yükseklik oranı
              ),
              itemCount: TakipUrunlerList2.length,
              itemBuilder: (context, index) {
                return SelectedProductCard(
                  Fiyat1: TakipUrunlerList2[index].birincimagazafiyat,
                  Fiyat2: TakipUrunlerList2[index].ikincimagazafiyat,
                  FotografYolu: TakipUrunlerList2[index].fotografYolu,
                  adi: TakipUrunlerList2[index].adi,
                  id: TakipUrunlerList2[index].id,
                  incelebutonu: TakipUrunlerList2[index].incelebutonu,
                  magaza1: TakipUrunlerList2[index].birincimagaza,
                  magaza2: TakipUrunlerList2[index].ikincimagaza,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
