import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection("users");

  Future<void> loginUser({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        // Kullanıcı başarıyla giriş yaptı. Burada yapılacak işlemler.
        print('Kullanıcı giriş yaptı: ${user.uid}');
      }
    } catch (e) {
      // Giriş yaparken hata oluştu.
      print('Giriş hatası: $e');
      throw e; // Hata durumunu yukarıya iletebilirsiniz.
    }
  }

  Future<void> registerUser({required String username, required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = _auth.currentUser;

      if (user != null) {
        await userCollection.doc(user.uid).set({
          "email": email,
          "username": username,
          "password": password,
        });
      }
    } catch (e) {
      print('Kayıt hatası: $e');
      throw e;
    }
  }
}
