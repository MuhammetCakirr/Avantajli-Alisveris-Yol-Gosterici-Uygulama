class ikiFiyatliUrun {
  final String id;
  final String adi;
  String fotografYolu;
  final String birincimagaza;
  final String ikincimagaza;
  final String birincimagazafiyat;
  final String ikincimagazafiyat;
  final String incelebutonu;

  ikiFiyatliUrun({
    required this.id,
    required this.adi,
    required this.fotografYolu,
    required this.birincimagaza,
    required this.ikincimagaza,
    required this.birincimagazafiyat,
    required this.ikincimagazafiyat,
    required this.incelebutonu
  });

  factory ikiFiyatliUrun.fromJson(Map<String, dynamic> json) {
    return ikiFiyatliUrun(
      id: json['Takip Urun id'],
      adi: json['Takip Urun Adi'],
      fotografYolu: json['Takip Urun Resim'],
      birincimagaza: json['Takip Birinci Magaza'],
      ikincimagaza: json['Takip Ikinci Magaza'],
      birincimagazafiyat: json['Takip Fiyat 1'] ,
      ikincimagazafiyat: json['Takip Fiyat 2'],
      incelebutonu: json['Takip incele Butonu']

    );
  }
}