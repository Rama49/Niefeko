import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  static bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
