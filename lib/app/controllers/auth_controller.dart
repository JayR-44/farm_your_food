// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';
//
//
// class AuthController extends GetxController {
//   OAuthCredential? _googleCredential;
//   AppleAuthProvider? _appleProvider;
//
//   final _auth = FirebaseAuth.instance;
//   final _user = Rx<User?>(null);
//
//   @override
//   void onInit() {
//     super.onInit();
//     _user.bindStream(_auth.userChanges());
//   }
//
//   User? get user => _user.value;
//
//   bool get userLoggedIn => _user.value != null;
//
//   Stream<User?> get userStream => _user.stream;
//
//   Future<User> signInWithEmail(
//     String email,
//     String password, {
//     bool temporarySignIn = false,
//   }) async {
//     try {
//       if (temporarySignIn) {
//         final tempApp = await Firebase.initializeApp(
//           name: 'Secondary',
//           options: Firebase.app().options,
//         );
//         final userCredential = await FirebaseAuth.instanceFor(
//           app: tempApp,
//         ).signInWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//         return userCredential.user!;
//       } else {
//         final userCredential = await _auth.signInWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//         return userCredential.user!;
//       }
//     } on FirebaseAuthException catch (e) {
//       throw AppException(
//         'Something Went Wrong',
//         e.message ?? '',
//       );
//     }
//   }
//
//   Future<User> signUpWithEmail(String email, String password) async {
//     try {
//       final tempApp = await Firebase.initializeApp(
//         name: 'Secondary',
//         options: Firebase.app().options,
//       );
//
//       final userCredential = await FirebaseAuth.instanceFor(
//         app: tempApp,
//       ).createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       return userCredential.user!;
//     } on FirebaseAuthException catch (e) {
//       throw AppException(
//         'Something Went Wrong',
//         e.message ?? '',
//       );
//     }
//   }
//
//   Future<User> signInWithGoogle({
//     bool temporarySignIn = false,
//   }) async {
//     try {
//       if (_googleCredential == null) {
//         final googleUser = await GoogleSignIn().signIn();
//         final googleAuth = await googleUser?.authentication;
//         _googleCredential = GoogleAuthProvider.credential(
//           accessToken: googleAuth?.accessToken,
//           idToken: googleAuth?.idToken,
//         );
//       }
//
//       if (temporarySignIn) {
//         final tempApp = await Firebase.initializeApp(
//           name: 'Secondary',
//           options: Firebase.app().options,
//         );
//
//         final userCredential = await FirebaseAuth.instanceFor(
//           app: tempApp,
//         ).signInWithCredential(
//           _googleCredential!,
//         );
//         return userCredential.user!;
//       } else {
//         final userCredential =
//             await _auth.signInWithCredential(_googleCredential!);
//         return userCredential.user!;
//       }
//     } on FirebaseAuthException catch (e) {
//       throw AppException(
//         'Something Went Wrong',
//         e.message ?? '',
//       );
//     } catch (e) {
//       throw const AppException(
//         'Something Went Wrong',
//         'Some thing went wrong please try again later.',
//       );
//     }
//   }
//
//   Future<User> signInWithApple({
//     bool temporarySignIn = false,
//   }) async {
//     try {
//       _appleProvider ??= AppleAuthProvider()
//         ..addScope('email')
//         ..addScope('fullName');
//
//       if (temporarySignIn) {
//         final tempApp = await Firebase.initializeApp(
//           name: 'Secondary',
//           options: Firebase.app().options,
//         );
//
//         final userCredential = await FirebaseAuth.instanceFor(
//           app: tempApp,
//         ).signInWithProvider(_appleProvider!);
//         return userCredential.user!;
//       } else {
//         final userCredential = await _auth.signInWithProvider(_appleProvider!);
//         return userCredential.user!;
//       }
//     } on FirebaseAuthException catch (e) {
//       throw AppException(
//         'Something Went Wrong',
//         e.message ?? '',
//       );
//     } catch (e) {
//       throw const AppException(
//         'Something Went Wrong',
//         'Some thing went wrong please try again later.',
//       );
//     }
//   }
//
//   Future<void> resetPassword(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//     } on FirebaseAuthException catch (e) {
//       throw AppException(
//         'Something Went Wrong',
//         e.message ?? '',
//       );
//     }
//   }
//
//   Future<void> changePassword(String oldPassword, String newPassword) async {
//     try {
//       final authCredential = EmailAuthProvider.credential(
//         email: _auth.currentUser?.email ?? '',
//         password: oldPassword,
//       );
//
//       final userCredential = await user?.reauthenticateWithCredential(
//         authCredential,
//       );
//
//       await userCredential?.user?.updatePassword(newPassword);
//     } on FirebaseAuthException catch (e) {
//       throw AppException(
//         'Something Went Wrong',
//         e.message ?? '',
//       );
//     }
//   }
//
//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//     } on FirebaseAuthException catch (e) {
//       throw AppException(
//         'Something Went Wrong',
//         e.message ?? '',
//       );
//     }
//   }
// }
