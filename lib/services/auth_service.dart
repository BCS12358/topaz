import 'package:firebase_auth/firebase_auth.dart';
import 'package:topaz/models/config/configuration.dart';
import 'package:topaz/services/database_service.dart';
import 'package:topaz/services/fcm_notification_service.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final FCMNotificationService fcmNotificationService =
      FCMNotificationService();

  Future<User?> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (ex) {
      // ignore: avoid_print
      print(ex.message);
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      String uid = credential.user!.uid;
      fcmNotificationService.getToken().then((userToken) {
        DatabaseService(uid: uid)
            .addConfiguration(configuration: Configuration(token: userToken!));
      });

      return credential.user;
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e.message);
      return null;
    }
  }
}
