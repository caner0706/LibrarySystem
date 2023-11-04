import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kitap Detayları'),
        backgroundColor: Colors.grey,
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
                  minimumSize: Size(double.infinity, 50),
                  primary: Colors.grey,
                ),
                child: Text(
                  'Kitap Adı: ${kitapAdi ?? 'Bilgi Yok'}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  primary: Colors.grey,
                ),
                child: Text(
                  'Yazar: ${yazar ?? 'Bilgi Yok'}',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  primary: Colors.grey,
                ),
                child: Text(
                  'Ekleniş Tarihi: ${eklenisTarihi?.toLocal() ?? 'Bilgi Yok'}',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  primary: Colors.grey,
                ),
                child: Text(
                  'Özet: ${ozet ?? 'Bilgi Yok'}',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 70),
              ElevatedButton(
                onPressed: () async {
                  bool success = await _firebaseService.reserveKitap(kitapAdi);

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Kitap rezerve edildi.'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Kitap rezerve edilemedi.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 30),
                  primary: Colors.grey,
                ),
                child: Text(
                  'Rezerve Et',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> reserveKitap(String kitapAdi) async {
    try {
      await _firestore.collection('reservation').add({
        'kitapAdi': kitapAdi,
      });
      return true; // Başarılı olduğunda true döndür
    } catch (e) {
      print('Hata: $e');
      return false; // Hata olduğunda false döndür
    }
  }
}
