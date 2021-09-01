// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

// abstract class IAuthGateway {
//   Future<void> signInWithEmailLink({required String email});

//   Future<String> signInAfterDeepLink({
//     required String email,
//     required String link,
//   });

//   Future<String> refreshUser();

//   Future signOutt();
// }

// class FirebaseAuthGateway implements IAuthGateway {
//   //FirebaseAuth? _auth;

//   //FirebaseAuthGateway() {
//   //  init();
//   //}

//   //init() async {
//   //  await Firebase.initializeApp();
//   //  final _auth = FirebaseAuth.instance;
//   //}

//   Future<void> signInWithEmailLink({required String email}) async {
//     try {
//       // await Firebase.initializeApp();
//       // final _auth = FirebaseAuth.instance;

//       //if (_auth == null) throw 'No Firebase Auth';

//       // await _auth.sendSignInLinkToEmail(
//       //     email: email,
//       //     actionCodeSettings: ActionCodeSettings(
//       //         url: 'https://satswala.web.app', // 'https://satswala.web.app',
//       //         handleCodeInApp: true,
//       //         androidInstallApp: true,
//       //         androidMinimumVersion: '12',
//       //         androidPackageName: 'com.example.dart',
//       //         iOSBundleId: 'com.sats.dart'));
//     } catch (e, s) {
//       print(
//         e.toString() + '\n\n' + s.toString(),
//       );
//     }
//   }

//   Future<String> signInAfterDeepLink({
//     required String email,
//     required String link,
//   }) async {
//     await Firebase.initializeApp();
//     // final _auth = FirebaseAuth.instance;

//     //if (_auth == null) throw 'No Firebase Auth';

//     // bool validLink = await _auth.isSignInWithEmailLink(link);
//     // if (validLink) {
//     //   final authResult = await _auth.signInWithEmailLink(
//     //     email: email,
//     //     emailLink: link,
//     //   );

//     //   final token = await authResult.user!.getIdToken();
//     //   return token;
//     // }

//     return '';
//   }

//   Future signOutt() async {
//     // await Firebase.initializeApp();
//     // final _auth = FirebaseAuth.instance;

//     // //if (_auth == null) throw 'No Firebase Auth';

//     // //_auth = FirebaseAuth.instance;
//     // await _auth.signOut();
//   }

//   @override
//   Future<String> refreshUser() async {
//     // await Firebase.initializeApp();
//     // final _auth = FirebaseAuth.instance;

//     // //if (_auth == null) throw 'No Firebase Auth';

//     // final user = await _auth.currentUser;
//     // if (user == null) return '';
//     // final token = await user.getIdToken(true);
//     // return token;
//     return '';
//   }
// }

// class DummyAuthGateway implements IAuthGateway {
//   @override
//   Future<String> signInAfterDeepLink(
//       {required String email, required String link}) async {
//     return '';
//   }

//   @override
//   Future<void> signInWithEmailLink({required String email}) async {}

//   @override
//   Future<String> refreshUser() async {
//     return '';
//   }

//   @override
//   Future signOutt() async {}
// }
