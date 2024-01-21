import 'package:flutter/material.dart';
import 'auth.dart';

class HomePage extends StatelessWidget {
  HomePage({required this.auth, required this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome'),
          actions: <Widget>[
            TextButton(
                onPressed: _signOut,
                child: const Text('Logout', style: TextStyle(fontSize: 17.0,color: Colors.black)))
          ],
        ),
        body: Container(
          child: const Center(
            child: Text('Welcome to homepage',style: TextStyle(fontSize: 32.0))
          ),
        )
      );
  }
}