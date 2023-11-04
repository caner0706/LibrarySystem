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
        bookData['id'] = doc.id; // Her belgeye id ekleniyor
        kitapAdlari.add(bookData);
      });
    } catch (e) {
      print('Hata: $e');
    }

    return kitapAdlari;
  }

  Future<void> deleteBook(String id) async {
    try {
      await booksCollection.doc(id).delete();
    } catch (e) {
      print('Hata: $e');
    }
  }

  Future<void> addBook(Map<String, dynamic> bookData) async {
    try {
      await booksCollection.add(bookData);
    } catch (e) {
      print('Hata: $e');
    }
  }
}
