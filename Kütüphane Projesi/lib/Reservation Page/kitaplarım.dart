import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Kitaplarim extends StatefulWidget {
  const Kitaplarim({Key? key});

  @override
  State<Kitaplarim> createState() => _KitaplarimState();
}

class _KitaplarimState extends State<Kitaplarim> {
  List<String> rezerveKitapListe = [];

  @override
  void initState() {
    super.initState();
    getReservations().then((reservations) {
      setState(() {
        rezerveKitapListe = reservations;
      });
    });
  }

  Future<List<String>> getReservations() async {
    QuerySnapshot<Map<String, dynamic>> reservations =
    await FirebaseFirestore.instance.collection('reservation').get();

    List<String> reservationList = [];
    reservations.docs.forEach((reservation) {
      reservationList.add(reservation.data()['kitapAdi']);
    });

    return reservationList;
  }

  void addKitap(String kitapAdi) {
    setState(() {
      rezerveKitapListe.add(kitapAdi);
      addToFirestore(kitapAdi);
    });
  }

  void removeKitap(int index) async {
    String kitapAdi = rezerveKitapListe[index];

    setState(() {
      rezerveKitapListe.removeAt(index);
    });

    await FirebaseFirestore.instance
        .collection('reservation')
        .where('kitapAdi', isEqualTo: kitapAdi)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }

  Future<void> addToFirestore(String kitapAdi) async {
    await FirebaseFirestore.instance.collection('reservation').add({
      'kitapAdi': kitapAdi,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              addKitap("Yeni Kitap");
            },
            child: Text('Kitap Ekle'),
          ),
          rezerveKitapListe.isEmpty
              ? Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.library_books,
                    size: 50,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Henüz bir kitap eklenmemiş.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Lütfen bir kitap rezerve edin.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          )
              : Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: rezerveKitapListe.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(rezerveKitapListe[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        removeKitap(index);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
