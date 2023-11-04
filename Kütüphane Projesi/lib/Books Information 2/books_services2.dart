import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  final CollectionReference booksCollection =
  FirebaseFirestore.instance.collection('books');


  Future<List<Map<String, dynamic>>> getBooks() async {
    List<Map<String, dynamic>> kitapAdlari = [];

    try {
      QuerySnapshot querySnapshot = await booksCollection.get();

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> bookData = doc.data() as Map<String, dynamic>;
        kitapAdlari.add(bookData);

      });
    } catch (e) {
      print('Hata: $e');
    }

    return kitapAdlari;
  }
}

