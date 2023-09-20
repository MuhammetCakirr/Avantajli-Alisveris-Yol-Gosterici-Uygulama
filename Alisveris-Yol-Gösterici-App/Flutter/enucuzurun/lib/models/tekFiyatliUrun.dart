class tekFiyatliUrun {
  final String id;
  final String adi;
  final String fotografYolu;
  final String Saticimagaza;
  final String indirimlifiyat;
  final String eskifiyat;
  final String incelebutonu;
  final String son30;
  final String bugunbasladi;

  tekFiyatliUrun({
    required this.id,
    required this.adi,
    required this.fotografYolu,
    required this.Saticimagaza,
    required this.indirimlifiyat,
    required this.eskifiyat,
    required this.incelebutonu,
    required this.son30,
    required this.bugunbasladi
  });
  
  factory tekFiyatliUrun.fromJson(Map<String, dynamic> json) {
    return tekFiyatliUrun(
      id: json['Indirimli Urun id'],
      adi: json['Indirimli Urun Adi'],
      fotografYolu: json['Indirimli Urun Resmi'],
      Saticimagaza: json['Indirimli Satici Magaza'],
      indirimlifiyat: json['Indirimli Fiyat'] ?? 0.0,
      eskifiyat: json['Indirimli Eski Fiyat'] ?? 0.0,
      incelebutonu: json['Indirimli Incele Butonu'],
      son30:json['Indirimli Son 30 gunun en ucuzu'],
      bugunbasladi:json['Indirimli Bugun basladi']

    );
  }
}
  

  