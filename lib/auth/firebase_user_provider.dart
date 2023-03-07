import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class LeadzFirebaseUser {
  LeadzFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

LeadzFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<LeadzFirebaseUser> leadzFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<LeadzFirebaseUser>(
        (user) => currentUser = LeadzFirebaseUser(user));
