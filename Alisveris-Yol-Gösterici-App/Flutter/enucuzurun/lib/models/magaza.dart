import 'dart:ui';

class Magaza {
  final String magazafoto;
  final String magazaurunad;
  double magazafiyat;
  final String magazafiyat2;
  final String guncellemetarihi;
  final String UrunDetayUrunAd;
  final String UrunDetayUrunFoto;
  final String UrunDetayEnucuzmagaza;
  final String UrunDetayEnucuzmagazafiyat;
  final String Kacmagazavar;

  Magaza( {
    required this.magazafiyat2,
    required this.UrunDetayUrunAd,
    required this.UrunDetayUrunFoto,
    required this.UrunDetayEnucuzmagaza,
    required this.UrunDetayEnucuzmagazafiyat,
    required this.Kacmagazavar,
    required this.magazafoto,
    required this.magazaurunad,
    required this.magazafiyat,
    required this.guncellemetarihi,
  });
}
