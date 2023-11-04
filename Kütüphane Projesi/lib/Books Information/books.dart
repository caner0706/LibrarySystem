import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Books Information/books_services.dart';
import 'book_details.dart';

class Kitaplar extends StatefulWidget {
  final FirestoreServices firestore = FirestoreServices();

  @override
  _KitaplarState createState() => _KitaplarState();
}

class _KitaplarState extends State<Kitaplar> {
  TextEditingController kitapAdiController = TextEditingController();
  TextEditingController yazarController = TextEditingController();
  TextEditingController ozetController = TextEditingController();

  void _showAddBookDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yeni Kitap Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: kitapAdiController,
                decoration: InputDecoration(labelText: 'Kitap Adı'),
              ),
              TextField(
                controller: yazarController,
                decoration: InputDecoration(labelText: 'Yazar'),
              ),
              TextField(
                controller: ozetController,
                decoration: InputDecoration(labelText: 'Özet'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                String kitapAdi = kitapAdiController.text;
                String yazar = yazarController.text;
                String ozet = ozetController.text;

                // Firebase'e kaydetme işlemi
                widget.firestore.addBook({
                  'Kitap Adı': kitapAdi,
                  'Yazar': yazar,
                  'Ekleniş Tarihi': DateTime.now(), // Otomatik tarih eklendi
                  'Özet': ozet,
                });

                // Bilgileri temizle
                kitapAdiController.clear();
                yazarController.clear();
                ozetController.clear();

                Navigator.pop(context);
              },
              child: Text('Kaydet'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kitaplar'),
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: false, // Geri gitme tuşunu kaldır
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: widget.firestore.getBooks(),
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
                DateTime eklenisTarihi = (kitapAdlari[index]['Ekleniş Tarihi'] as Timestamp).toDate();

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: EdgeInsets.all(5.0),
                  child: ListTile(
                    title: Text(kitapAdlari[index]['Kitap Adı']),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        widget.firestore.deleteBook(kitapAdlari[index]['id']);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailsPage(
                            kitapAdi: kitapAdlari[index]['Kitap Adı'],
                            yazar: kitapAdlari[index]['Yazar'],
                            ozet: kitapAdlari[index]['Özet'],
                            eklenisTarihi: eklenisTarihi,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddBookDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
