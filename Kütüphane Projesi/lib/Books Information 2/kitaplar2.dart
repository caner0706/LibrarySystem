import 'package:flutter/material.dart';
import '../Books Information/books_services.dart';
import 'book_details2.dart';

class Kitaplar2 extends StatelessWidget {
  final FirestoreServices firestore = FirestoreServices();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: firestore.getBooks(),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>>? kitapAdlari = snapshot.data;

          return ListView.builder(
            itemCount: kitapAdlari!.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: EdgeInsets.all(5.0),
                child: ListTile(
                  title: Text(kitapAdlari[index]['Kitap Adı']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailsPage(
                          kitapAdi: kitapAdlari[index]['Kitap Adı'],
                          yazar: kitapAdlari[index]['Yazar'],
                          ozet: kitapAdlari[index]['Özet'],
                          eklenisTarihi: kitapAdlari[index]['Ekleniş Tarihi'].toDate(),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
