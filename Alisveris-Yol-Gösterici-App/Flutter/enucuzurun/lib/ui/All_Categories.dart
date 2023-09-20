import 'package:enucuzurun/controller/Web_services.dart';
import 'package:enucuzurun/models/kategori.dart';
import 'package:enucuzurun/ui/Home_Page.dart';
import 'package:enucuzurun/widgets/Categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({super.key});

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  final WebService webService = Get.find<WebService>();
  List<Kategori> kategorilerr=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webService.KategorileriDoldur();
    kategorilerr=webService.kategoriler;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Padding(
                padding: const EdgeInsets.only( right:10.0),
                child: Text(
                      "Tüm Kategoriler",
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
              ),
            ],
          ),
          Container(
              height: MediaQuery.of(context).size.height *1,      
              child: Padding(
                padding: const EdgeInsets.only(right: 6.0,left:6.0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: kategorilerr.length,
                  itemBuilder: (context, index) {
                    return Categories(
                      kategoriAd: kategorilerr[index].adi,
                      kategoriImgUrl: kategorilerr[index].fotografYolu,
                      url: kategorilerr[index].url,
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }
}