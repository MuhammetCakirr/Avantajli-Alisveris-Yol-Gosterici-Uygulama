
import 'package:enucuzurun/models/magaza.dart';
import 'package:enucuzurun/ui/Home_Page.dart';
import 'package:enucuzurun/widgets/Product_Stores.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  
    List<Magaza> magazalarr=[];
   
   ProductDetail(
    {
      super.key,
      required this.magazalarr
    }
    );

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  @override
  Widget build(BuildContext context) {
    widget.magazalarr.sort((a, b) => a.magazafiyat.compareTo(b.magazafiyat));
    return Scaffold(
      
      backgroundColor: Color(0xFFF5F5F5),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.47,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.bottomLeft,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: IconButton(
                        onPressed: () {
                          
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        icon: Icon(Icons.arrow_back_ios_new),
                      )),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Colors.transparent,
                  child:Image.network(widget.magazalarr[0].UrunDetayUrunFoto,
                      fit:BoxFit.contain ,) 

                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0, top: 8),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.magazalarr[0].UrunDetayUrunAd,
                            style: TextStyle(
                              color: Colors.black,
                               fontSize: 14,
                               fontFamily: AutofillHints.addressCityAndState,
                               fontWeight: FontWeight.w700
                               
                               ),
                          ),
                          //Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Container(
                             height: MediaQuery.of(context).size.height * 0.04,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                     widget.magazalarr[0].UrunDetayEnucuzmagazafiyat.toString()+" TL",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child:Image.network(widget.magazalarr[0].magazafoto,
                                        width: 100,
                                        height: 80, )  
                                                      
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
               widget.magazalarr[0].Kacmagazavar,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.magazalarr.length,
                itemBuilder: (_, index) {
                  
                     return ProductStores(magazafoto: widget.magazalarr[index].magazafoto, magazaurunad: widget.magazalarr[index].magazaurunad, magazafiyat: widget.magazalarr[index].magazafiyat.toString(), guncellemetarihi: widget.magazalarr[index].guncellemetarihi,urunfiyat: widget.magazalarr[index].UrunDetayEnucuzmagazafiyat, magazafiyat2: widget.magazalarr[index].magazafiyat2,);
                  
                 
                }),
          )
        ],
      ),
    );
  }
}
