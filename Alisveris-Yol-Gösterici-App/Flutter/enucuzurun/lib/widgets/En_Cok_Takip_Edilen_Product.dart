import 'package:enucuzurun/models/kategori.dart';
import 'package:flutter/material.dart';

class UrunKarti extends StatelessWidget {
  final Kategori kategori;

  UrunKarti({required this.kategori});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0), // Kenarları yuvarlatır
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            kategori.fotografYolu,
            width: double.infinity,
            height: 150.0,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10.0),
          Text(
            kategori.adi,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          Text(
            '\$${kategori.adi}',
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
