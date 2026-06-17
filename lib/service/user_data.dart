import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  static User? get user => FirebaseAuth.instance.currentUser;

  static String get userImageUrl => user?.photoURL ?? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png";
  static String get userName => user?.displayName ?? "Guest User";
  static String get userEmail => user?.email ?? "Not signed in";
}
