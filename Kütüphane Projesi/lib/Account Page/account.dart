import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Login Page/login.dart';

class Hesabim extends StatefulWidget {
  @override
  _HesabimState createState() => _HesabimState();
}

class _HesabimState extends State<Hesabim> {
  final User? user = FirebaseAuth.instance.currentUser;
  bool isLoggingOut = false;

  void _handleSignOut() {
    setState(() {
      isLoggingOut = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hesabım'),
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(user?.photoURL ?? ''),
            ),
            SizedBox(height: 20),
            Text(
              'Merhaba',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              user?.displayName ?? '',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              user?.email ?? '',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: isLoggingOut ? null : _handleSignOut,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                primary: Colors.grey,
              ),
              child: Text(
                isLoggingOut ? 'Çıkış Yapılıyor...' : 'Çıkış Yap',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
