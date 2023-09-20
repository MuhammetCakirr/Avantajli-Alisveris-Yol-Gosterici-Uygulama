import 'dart:convert';
import 'package:enucuzurun/models/ikiFiyatliUrun.dart';
import 'package:enucuzurun/models/kategori.dart';
import 'package:enucuzurun/models/magaza.dart';
import 'package:enucuzurun/models/tekFiyatliUrun.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class WebService extends GetxController{
  List<Kategori> kategoriler=[];
  KategorileriDoldur(){
    kategoriler = [
      Kategori(adi: "Telefonlar", fotografYolu: "assets/iphone.png",url:"/cep-telefonlari" ),
      Kategori(adi: "Macbooklar", fotografYolu: "assets/mac.png",url:"/macbook"),
      Kategori(adi: "Akıllı Saatler", fotografYolu: "assets/akillisaatlerr.png",url:"/akilli-saat"), 
      Kategori(adi: "Cilt Bakım", fotografYolu: "assets/ciltbakim2.png",url:"/cilt-ve-yuz-bakimi"),
      Kategori(adi: "Mutfak Aletleri", fotografYolu: "assets/airfrey.png",url:"/elektrikli-mutfak-aletleri"),
      Kategori(adi: "Kitaplar", fotografYolu: "assets/romanlar.png",url:"/roman"),
      Kategori(adi: "Televizyonlar", fotografYolu: "assets/tvler.png",url:"/televizyonlar" ),
      Kategori(adi: "Buzdolapları", fotografYolu: "assets/buzdolablari.png",url:"/buzdolaplari"),
      Kategori(adi: "Masaüstü Bilgisayar", fotografYolu: "assets/masaustu.png",url:"/masaustu-bilgisayar"), 
      Kategori(adi: "Dizüstü Bilgisayar", fotografYolu: "assets/dizustu.png",url:"/dizustu-bilgisayar"),
      Kategori(adi: "Fotoğraf Makineleri", fotografYolu: "assets/fotografmakinesi.png",url:"/dijital-fotograf-makineleri"),
      Kategori(adi: "Oyuncaklar", fotografYolu: "assets/oyuncaklar.png",url:"/oyuncak"),
      Kategori(adi: "Figürler", fotografYolu: "assets/figurler.png",url:"/aksiyon-figurleri"),
      Kategori(adi: "Makyaj Ürünleri", fotografYolu: "assets/makyajlar.png",url:"/makyaj-urunleri  " ),
      Kategori(adi: "Ağız ve Diş Sağlığı", fotografYolu: "assets/agizvedis.png",url:"/agiz-ve-dis-sagligi"),
      Kategori(adi: "Parfümler", fotografYolu: "assets/parfumler.png",url:"/parfumler"), 
      Kategori(adi: "PetShop Ürünler", fotografYolu: "assets/petshop.png",url:"/pet"),
      Kategori(adi: "Gitarlar", fotografYolu: "assets/gitarlar.png",url:"/klasik-gitarlar"),
    ];
  }
  
   List<Magaza> magazalar=[];  
   final List<tekFiyatliUrun> IndirimliUrunlerList = [];
   final List<ikiFiyatliUrun> TakipUrunlerList = [];
   List<ikiFiyatliUrun> SelectedCategoryProductList=[];
   List<ikiFiyatliUrun> SearchList=[];

  Future<void> fetchData() async {
  final response = await http.get(Uri.parse('http://192.168.1.114:8000/HomePage/'));
  if (response.statusCode == 200) {
    //final Map<String, dynamic> data = json.decode(response.body);
    final Map<String, dynamic> jsonData = json.decode(response.body);
    final urunler = jsonData['Urunler'] as List<dynamic>;
    
    for (final urun in urunler) {
    final uruntipi = urun['Type'];
    switch (uruntipi) {
      case 'ProductA':
        final indirimliUrun = tekFiyatliUrun.fromJson(urun);
        
        IndirimliUrunlerList.add(indirimliUrun);
        break;
      case 'ProductB':
        final takipUrun = ikiFiyatliUrun.fromJson(urun);
        TakipUrunlerList.add(takipUrun);
        break;
      default:
        print('Bilinmeyen ürün türü: $uruntipi');
    }
    }
      List<tekFiyatliUrun> geciciList=[];
      List<ikiFiyatliUrun> geciciListtakip=[];
      geciciList.addAll(IndirimliUrunlerList);
      geciciListtakip.addAll(TakipUrunlerList);
    for(var indirimli in geciciList)
    {
      if(indirimli.fotografYolu=="Bilinmiyor")
      {
        IndirimliUrunlerList.remove(indirimli);
      }
    }
    for(var takip in geciciListtakip)
    {
      if(takip.fotografYolu=="Bilinmiyor")
      {
        TakipUrunlerList.remove(takip);
      }
      if(takip.birincimagaza=="Bulunamadı" ||takip.ikincimagaza=="Bulunamadı" || takip.birincimagazafiyat=="Bulunamadı"|| takip.ikincimagazafiyat=="Bulunamadı")
      {
        TakipUrunlerList.remove(takip);
      }
    }

    print('Indırımli ürünler:');
    for (final indirimli in IndirimliUrunlerList) {
      print('ID: ${indirimli.id}, Ad: ${indirimli.adi}, Fiyat: ${indirimli.indirimlifiyat},Magaza: ${indirimli.Saticimagaza},FotografYolu: ${indirimli.fotografYolu},Eski Fiyat: ${indirimli.eskifiyat},Incele Butonu: ${indirimli.incelebutonu}');
      print("\n");
    }
    

    print('Takip Edilen ürünler:');
    for (final takip in TakipUrunlerList) {
      print('ID: ${takip.id}, Ad: ${takip.adi}, Fiyat 1: ${takip.birincimagazafiyat},Magaza 1: ${takip.birincimagaza},FotografYolu: ${takip.fotografYolu}, Fiyat 2: ${takip.ikincimagazafiyat},Magaza 2: ${takip.ikincimagaza},Incele Butonu: ${takip.incelebutonu}');
      print("\n");
    }
  } 
  else {
    
    throw Exception('HTTP isteği başarısız: ${response.statusCode}');
  }
}
  
  Future<void> sendRequest(String id) async {
    try {
      final url = Uri.parse('http://192.168.1.114:8000/ProductDetailPage/'); 
      final response = await http.post(url, body: {'veri': id});
       
      if (response.statusCode == 200) {
        
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final bilgiler = jsonData['Bilgiler'] as List<dynamic>;
        magazalar.clear();
        for(final bilgi in bilgiler)
        {
         var magaza=Magaza(
             magazafoto: bilgi['magazafoto'],
             magazaurunad: bilgi['magazaurunad'], 
             magazafiyat: double.parse(bilgi['magazafiyat']), 
             guncellemetarihi: bilgi['guncellemetarihi'], 
             UrunDetayUrunAd: bilgi['Urun Adi'], 
             UrunDetayUrunFoto: bilgi['Urun Fotografi'], 
             UrunDetayEnucuzmagaza: bilgi['En Ucuz Magaza'], 
             UrunDetayEnucuzmagazafiyat: bilgi['En Ucuz Magaza Fiyat'], 
             Kacmagazavar: bilgi['Kac magaza var'],
             magazafiyat2: bilgi['magazafiyat2']
             );
          magazalar.add(magaza);
          print(bilgi);
        }
        print("Magazalar lenght:"+ magazalar.length.toString());

      } else {
        print('İstek başarısız: ${response.statusCode}');
      }

      for(var magaza in magazalar)
      {
       String fiyatverisi= magaza.magazafiyat.toString();
       fiyatverisi = fiyatverisi.replaceAll(" TL", "");
       print("Fiyat Verisi"+fiyatverisi);
       double fiyat = double.parse(fiyatverisi.replaceAll(",", ""));
       magaza.magazafiyat=fiyat;
       print("magaza fiyat"+magaza.magazafiyat.toString());
      }

      
    } catch (error) {
      print('Hata oluştu: $error');
    }
  }

  Future<void> sendRequestCategory(String gelenurl) async {
    try {
      final url = Uri.parse('http://192.168.1.114:8000/SelectedProductPage/'); 
      final response = await http.post(url, body: {'veri': gelenurl}); 
      if (response.statusCode == 200) {
        
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final bilgiler = jsonData['Bilgiler'] as List<dynamic>;
        print(bilgiler);
        SelectedCategoryProductList.clear();
        for(final bilgi in bilgiler)
        {
            final takipUrun = ikiFiyatliUrun.fromJson(bilgi);
            if(takipUrun.fotografYolu=="Bilinmiyor")
            {
              takipUrun.fotografYolu="https://cdn.cimri.io/image/178x178/apple-macbook-air-mlxw3tua-m2-8c-8gpu-8-gb-ram-256-gb-ssd-136-dizustu-bilgisayar_654088689.jpg";
            }
            //akipUrun.fotografYolu="https:"+takipUrun.fotografYolu;
            SelectedCategoryProductList.add(takipUrun);
            print(takipUrun);
        }

         List<ikiFiyatliUrun> geciciList=[];
         geciciList.addAll(SelectedCategoryProductList);
        for(var urun in geciciList)
        {
          if(urun.fotografYolu=="Bilinmiyor")
          {
            SelectedCategoryProductList.remove(urun);
          }
          if(urun.adi=="Bilinmiyor")
          {
            SelectedCategoryProductList.remove(urun);
          }
          if(urun.birincimagaza=="Bulunamadı" && urun.ikincimagaza=="Bulunamadı")
          {
            SelectedCategoryProductList.remove(urun);
          }
        }
         
        print("SelectedCategoryProduct lenght:"+ SelectedCategoryProductList.length.toString());

      } else {
        print('İstek başarısız: ${response.statusCode}');
      }

    } catch (error) {
      print('Hata oluştu: $error');
    }
  }

  Future<void> sendRequestsearch(String gelenurl) async {
    try {
      final url = Uri.parse('http://192.168.1.114:8000/SearchPage/'); 
      final response = await http.post(url, body: {'veri': gelenurl}); 
      if (response.statusCode == 200) {
        
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final bilgiler = jsonData['Bilgiler'] as List<dynamic>;
        print(bilgiler);
        SearchList.clear();
        for(final bilgi in bilgiler)
        {
            final takipUrun = ikiFiyatliUrun.fromJson(bilgi);
            if(takipUrun.fotografYolu=="Bilinmiyor")
            {
              takipUrun.fotografYolu="https://cdn.cimri.io/image/178x178/apple-macbook-air-mlxw3tua-m2-8c-8gpu-8-gb-ram-256-gb-ssd-136-dizustu-bilgisayar_654088689.jpg";
            }
            //akipUrun.fotografYolu="https:"+takipUrun.fotografYolu;
            SearchList.add(takipUrun);
            print(takipUrun);
        }

         List<ikiFiyatliUrun> geciciList=[];
         geciciList.addAll(SearchList);
        for(var urun in geciciList)
        {
          if(urun.fotografYolu=="Bilinmiyor")
          {
            SearchList.remove(urun);
          }
          if(urun.adi=="Bilinmiyor")
          {
            SearchList.remove(urun);
          }
          if(urun.birincimagaza=="Bulunamadı" && urun.ikincimagaza=="Bulunamadı")
          {
            SearchList.remove(urun);
          }
        }
         
        print("SelectedCategoryProduct lenght:"+ SearchList.length.toString());

      } else {
        print('İstek başarısız: ${response.statusCode}');
      }

    } catch (error) {
      print('Hata oluştu: $error');
    }
  }


}
