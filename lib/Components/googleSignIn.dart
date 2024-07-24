import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Googlesignin extends StatefulWidget {
  const Googlesignin({super.key});

  @override
  State<Googlesignin> createState() => _GooglesigninState();
}

class _GooglesigninState extends State<Googlesignin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TextButton(
      onPressed: () {
        SignInWithGoogle();
      },
      child: Center(
        child: Text(
          'SignInWithGoogle',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
    ));
  }

  SignInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleAuth =
        await googleSignInAccount!.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(authCredential);
    print('SignInWithGoogle');
    print(userCredential.user?.displayName);
  }
}
