import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User get currentUser => _auth.currentUser!;

  Future<UserCredential> loginWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({"uid": currentUser.uid, "email": email});
      print('Login successful');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Login failed: ${e.message}');
      throw e;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    print('Logged out');
  }

  Future<UserCredential> registerWithEmailPassword(
      String email, String password, String userName) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      print('Registration successful');
      await firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({"uid": currentUser.uid, "email": email, "username": userName});
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Registration failed: ${e.message}');
      throw e;
    }
  }
}
