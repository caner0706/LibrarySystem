import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  final String kitapAdi;
  final String yazar;
  final String ozet;
  final DateTime eklenisTarihi;

  BookDetailsPage({
    required this.kitapAdi,
    required this.yazar,
    required this.ozet,
    required this.eklenisTarihi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kitap Detayları'),
        backgroundColor: Colors.grey, // AppBar rengi
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Buton boyutları
                  primary: Colors.grey, // Buton rengi
                ),
                child: Text(
                  'Kitap Adı: ${kitapAdi ?? 'Bilgi Yok'}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center, // Yazının ortalanması
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Buton boyutları
                  primary: Colors.grey, // Buton rengi
                ),
                child: Text(
                  'Yazar: ${yazar ?? 'Bilgi Yok'}',
                  textAlign: TextAlign.center, // Yazının ortalanması
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Buton boyutları
                  primary: Colors.grey, // Buton rengi
                ),
                child: Text(
                  'Ekleniş Tarihi: ${eklenisTarihi?.toLocal() ?? 'Bilgi Yok'}',
                  textAlign: TextAlign.center, // Yazının ortalanması
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Buton boyutları
                  primary: Colors.grey, // Buton rengi
                ),
                child: Text(
                  'Özet: ${ozet ?? 'Bilgi Yok'}',
                  textAlign: TextAlign.center, // Yazının ortalanması
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
