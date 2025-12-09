import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signInWithPhone(String verificationId, String smsCode);
  Future<void> verifyPhoneNumber(
    String phoneNumber,
    Function(String) onCodeSent,
    Function(String) onError,
  );
  Future<UserCredential> signInWithGoogle();
  Future<UserModel?> getUserData(String uid);
  Future<void> saveUserData(UserModel user);
  Future<void> signOut();
  User? getCurrentUser();
  Stream<User?> authStateChanges();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
    required this.googleSignIn,
  });

  @override
  Future<void> verifyPhoneNumber(
    String phoneNumber,
    Function(String) onCodeSent,
    Function(String) onError,
  ) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        onError(e.message ?? 'فشل التحقق');
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(seconds: 60),
    );
  }

  @override
  Future<UserCredential> signInWithPhone(
    String verificationId,
    String smsCode,
  ) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return await firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) throw Exception('تم إلغاء تسجيل الدخول');

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<UserModel?> getUserData(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc);
  }

  @override
  Future<void> saveUserData(UserModel user) async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .set(user.toFirestore(), SetOptions(merge: true));
  }

  @override
  Future<void> signOut() async {
    await Future.wait([firebaseAuth.signOut(), googleSignIn.signOut()]);
  }

  @override
  User? getCurrentUser() => firebaseAuth.currentUser;

  @override
  Stream<User?> authStateChanges() => firebaseAuth.authStateChanges();
}
