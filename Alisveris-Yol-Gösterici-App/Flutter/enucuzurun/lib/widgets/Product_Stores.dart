import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductStores extends StatelessWidget {
  final String magazafoto;
  final String magazaurunad;
  final String magazafiyat;
  final String guncellemetarihi;
  final String urunfiyat;
  final  String magazafiyat2;
  const ProductStores({
    Key? key, required this.magazafoto, required this.magazaurunad, required this.magazafiyat, required this.guncellemetarihi, required this.urunfiyat, required this.magazafiyat2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*var magazafiyat2;
    var sinir=urunfiyat.length;
    if(sinir==9){
      if(Sayac=="0"){
        magazafiyat2=urunfiyat;
      }
      if(magazafiyat.length==4)
      {
          magazafiyat2=magazafiyat + "00" ;
      } 
      if(magazafiyat.length==5)
      {
        magazafiyat2=magazafiyat+"0";
      }
      if(magazafiyat.length==8)
      {
       magazafiyat2 = magazafiyat.substring(0, 6) + "," + magazafiyat.substring(7);
      }
      
    }
    
      
    if(magazafiyat.length==8)
    {
       magazafiyat2 = magazafiyat.substring(0, 6) + "," + magazafiyat.substring(6);
    }    
    
   if(magazafiyat.length==3 )
      {
          magazafiyat2=magazafiyat + "00" ;
      }
    if(magazafiyat.length==4)
      {
          magazafiyat2=magazafiyat + "0" ;
      }  

    if(magazafiyat.length==5)
    {
      magazafiyat2=magazafiyat;
    }
    if(magazafiyat.length==6)
    {
      magazafiyat2=magazafiyat.substring(0, 5) + "," + magazafiyat.substring(5);
    }*/
    
    return Padding(
      padding: const EdgeInsets.only(left:10,right: 10,top: 10,),
      child: Container( 
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1,color: Colors.white)
        ),
        child: Column(
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Text(
                    magazafiyat2.toString()+" TL",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child:Image.network(magazafoto,
                                  width: 100,
                                  height: 50, ) 
                  
                  
                )
              ],
            ),
            Row(  
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 5,),
                    Icon(
                      Icons.fire_truck
                    ),
                    SizedBox(width: 8,),
                    Text(
                      "Ücretsiz Kargo",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                      guncellemetarihi,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          ),
                    ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
