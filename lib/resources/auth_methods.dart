import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_9/utils/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';



class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


 

  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,

      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL,
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      res = false;
    }
    return res;
  }

  void signOut(BuildContext context) async {
    try {
    await  _auth.signOut();
     Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      print(e);
    }
  }

 // EMAIL SIGN UP
  Future<String> signUpWithEmail({
    required String email,
    required String password,
    required String newuser,
    required BuildContext context,
  }) async {
    String res = 'Missing Field';
    try {
     if(email.isNotEmpty&&password.isNotEmpty&&newuser.isNotEmpty) {
        UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
        
      );
      //update the username in firebase
    User? user = result.user;
   user!.updateDisplayName(newuser);
   
      if (result.additionalUserInfo!.isNewUser) {
    
    await _firestore.collection('users').doc(result.user!.uid).set({
      'username':newuser,
      'uid': user.uid
    });
    
    res = 'success';
  }
}} on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      showSnackBar(
          context, e.message!); // Displaying the usual firebase error message
    }
    return res;
  }

   // EMAIL LOGIN
  Future<String> loginWithEmail({
    required String email,
    required String password,
   // required String name,
    required BuildContext context,
    
  }) async {
    String res = 'Missing Field';
    try {
      UserCredential result =
       await _auth.signInWithEmailAndPassword(
        email: email,
        
        password: password,
      );
       if (result.additionalUserInfo!.username != null) {
    
    await _firestore.collection('users').doc(result.user!.uid).get();}
   //    User? user = result.user;
   //   user!.updateDisplayName(name);
      
       res = 'success';
    
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
    return res;
  }


  
  
   
}//end of class
