
import 'package:enucuzurun/controller/Web_services.dart';
import 'package:enucuzurun/models/ikiFiyatliUrun.dart';
import 'package:enucuzurun/ui/Selected_Product_Page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Categories extends StatefulWidget {
  final String kategoriAd;
  final String kategoriImgUrl;
  final String url;
  const Categories({super.key,required this.kategoriAd,required this.kategoriImgUrl,required this.url});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final WebService webService = Get.find<WebService>();
  List<ikiFiyatliUrun> urunler=[];
  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:2.0),
      child: GestureDetector(
        onTap: () async {
          await webService.sendRequestCategory(widget.url);
          urunler=webService.SelectedCategoryProductList;
          Navigator.push(
            context,
             MaterialPageRoute(
            builder: (context) => SelectedProducts(urunler: urunler, ), 
    ),
             );
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Image.asset(
                        widget.kategoriImgUrl,
                        width: 70.0, 
                        height: 80.0, 
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            widget.kategoriAd,
                            style: TextStyle(
                              fontSize: 10,            
                              color: Colors.black,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
