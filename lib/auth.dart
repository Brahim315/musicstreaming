import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

  abstract class BaseAuth {
    Future<String?> signInWithEmailAndPassword(String email, String password);
    Future<String?> createUserWithEmailAndPassword(String email,String password);
    Future<String?> currentUser();
    Future<void> signOut();
  }

   class Auth implements BaseAuth{
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

      Future<String?> signInWithEmailAndPassword(String email, String password) async {
        UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        return userCredential.user?.uid;
      }

      Future<String?> createUserWithEmailAndPassword(String email,String password) async {
        UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        return userCredential.user?.uid;
      }

      Future<String?> currentUser() async {
        var currentUser = _firebaseAuth.currentUser;
          return currentUser?.uid;

      }

      Future<void> signOut() async {
        return _firebaseAuth.signOut();
      }
   }