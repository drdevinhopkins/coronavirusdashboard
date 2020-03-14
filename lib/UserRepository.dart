// TODO Implement this library.import 'dart:async';

// import 'package:firebase/firebase.dart';
// import 'package:firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'dart:convert';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:meta/meta.dart';

// enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // static Firestore _firestore = firestore();
  // CollectionReference userDB = _firestore.collection('users');

  // FirebaseUser _user;
  // Status _status = Status.Unauthenticated;
  // var notAnonymous;
  // var errorMessage = "No errors";

  var locations = {
    'jgh-ed': 'Hôpital général juif',
    'st-marys': 'Centre hospitalier de St. Mary',
    'suroit': 'Centre hospitalier du Suroît'
  };

  var chosenLocation;

  // Status get status => _status;
  // FirebaseUser get user => _user;

  // String nextScreen;

  // final TextEditingController _phoneNumberController = TextEditingController();
  // final TextEditingController _smsController = TextEditingController();
  // String _verificationId;
  // String _message;
  // TextEditingController get phoneNumberController => _phoneNumberController;
  // TextEditingController get smsController => _smsController;
  // String get verficationId => _verificationId;
  // String get message => _message;

  // staticStreamSubscription userAuthSub;

  // UserRepository() {
  //   _auth.onAuthStateChanged.listen((newUser) {
  //     // print('AuthProvider - FirebaseAuth - onAuthStateChanged - $newUser');
  //     _user = newUser;
  //     _status = Status.Authenticated;
  //     // addToFirestore();
  //     notifyListeners();
  //   }, onError: (e) {
  //     errorMessage = e.message;
  //     notifyListeners();

  //     _status = Status.Unauthenticated;

  //     //     // print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
  //   });
  // }

  // Future<FirebaseUser> handleSignIn(loginType, email, password, context) async {
  // Future<String> handleSignIn(loginType) async {
  // _status = Status.Authenticating;
  // notifyListeners();
  // AuthCredential _credential;

  // switch (loginType) {
  // case 'google':
  //   {
  //     final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     final AuthCredential googleCredential =
  //         GoogleAuthProvider.getCredential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     _credential = googleCredential;
  //     _user = (await _auth.signInWithCredential(_credential)).user;
  //   }
  //   break;
  // case 'facebook':
  //   {
  //     var _fbWebAuth = fb_web.auth();
  //     var _facebookSignIn = fb_web.FacebookAuthProvider();
  //     var _fbLogin = await _fbWebAuth.signInWithPopup(_facebookSignIn);
  //     var fbAccessToken = _fbLogin.credential.accessToken;
  //     _credential =
  //         FacebookAuthProvider.getCredential(accessToken: fbAccessToken);
  //     _user = (await _auth.signInWithCredential(_credential)).user;
  //   }
  //   break;
  // case 'email':
  //   {
  //     _status = Status.Authenticating;
  //     notifyListeners();
  //     try {
  //       _user = (await _auth.signInWithEmailAndPassword(
  //               email: email, password: password))
  //           .user;
  //       _status = Status.Authenticated;
  //       notAnonymous = true;
  //       notifyListeners();
  //       Navigator.pushReplacementNamed(context, '/Home');
  //     } catch (e) {
  //       errorMessage = e.message;
  //       notifyListeners();
  //     }
  //   }
  //   break;

  // case 'anonymous':
  //   {
  //     _status = Status.Authenticating;
  //     notifyListeners();
  //     _user = (await _auth.signInAnonymously()).user;
  //     _status = Status.Authenticated;
  //     notAnonymous = false;
  //     notifyListeners();
  //     Navigator.pushReplacementNamed(context, '/Home');
  //   }
  //   break;
  // case 'phone':
  //   {
  //     var _fbWebAuth = fb_web.auth();
  //     var verifier = fb_web.RecaptchaVerifier('recaptcha-container', {
  //       "size": "invisible",
  //       "callback": (resp) {
  //         print("Successful reCAPTCHA response");
  //       },
  //       "expired-callback": () {
  //         print("Response expired");
  //       }
  //     });
  //     verifier.verify();
  //     _fbWebAuth.signInWithPhoneNumber('+1 514-655-5097', verifier);
  //     _verifyPhoneNumber();
  //   }
  // }
  // _onAuthStateChanged(_user);

  //   return _user;
  // }

  // void _verifyPhoneNumber() async {
  //   final PhoneVerificationCompleted verificationCompleted =
  //       (AuthCredential phoneAuthCredential) {
  //     _auth.signInWithCredential(phoneAuthCredential);
  //   };

  //   final PhoneVerificationFailed verificationFailed =
  //       (AuthException authException) {};

  //   final PhoneCodeSent codeSent =
  //       (String verificationId, [int forceResendingToken]) async {
  //     _verificationId = verificationId;
  //   };

  //   final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
  //       (String verificationId) {
  //     _verificationId = verificationId;
  //   };

  //   await _auth.verifyPhoneNumber(
  //       phoneNumber: "+15146555097",
  //       timeout: const Duration(seconds: 5),
  //       verificationCompleted: verificationCompleted,
  //       verificationFailed: verificationFailed,
  //       codeSent: codeSent,
  //       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  // }

  // Future<dynamic> signOut(context) async {
  //   try {
  //     // return Future.wait([_auth.signOut()]);
  //     Future.wait([_auth.signOut()]);
  //     _status = Status.Unauthenticated;
  //     notifyListeners();
  //     Navigator.pushReplacementNamed(context, '/Login');
  //   } catch (e) {
  //     print('Error signin out: $e');
  //     // return e;
  //     throw '$e';
  //   }
  // }

  // void addToFirestore() async {
  //   var newData = {
  //     'uid': _user.uid,
  //     'displayName': _user.displayName,
  //     'photoUrl': _user.photoUrl,
  //     'email': _user.email,
  //     'lastActive': DateTime.now(),
  //   };

  //   try {
  //     await userDB.doc(user.uid).set(newData, SetOptions(merge: true));
  //   } catch (e) {
  //     print('Error while writing document, $e');
  //   }
  // }
}
