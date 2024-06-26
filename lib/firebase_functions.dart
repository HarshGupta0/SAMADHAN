import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'navScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void createUserWithEmailAndPassword(String emailAddress, String password, String name, String phoneNumber, BuildContext context) async {
  try {
    // Create user with email and password
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    // Get the created user
    User? user = credential.user;

    if (user != null) {
      // Store user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': name,
        'email': emailAddress,
        'phoneNumber': phoneNumber,
        'userId': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
        // Add any other user information here
      });

      // Navigate to the main screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavScreen()));

      // Show success message
      MySnackbar(context, "User Registered", Colors.green);
    } else {
      // Handle other cases here if needed
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      MySnackbar(context, "Weak password", Colors.orange.shade500);
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      MySnackbar(context, "The account already exists for that email.", Colors.brown.shade400);
      print('The account already exists for that email.');
    } else {
      print(e);
    }
  } catch (e) {
    print(e);
  }
}

// SnackBar
MySnackbar(BuildContext context, String Message, Color colors) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: colors,
      content: Text(Message),
    ),
  );
}

// Sign-In Function
signInWithEmailAndPassword(String emailAddress, String password, BuildContext context) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    User? user = credential.user;
    if (user != null) {
      // _saveUserUid(user.uid);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavScreen()));
      MySnackbar(context, "Login Successfully", Colors.green);
    } else {
      // Handle other cases here if needed
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      MySnackbar(context, "No user found for that email.", Colors.red);
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      MySnackbar(context, "Wrong password provided for that user", Colors.red);
      print('Wrong password provided for that user.');
    } else {
      print('Error code: ${e.code}');
    }
  }
}

// Signout Function
Signout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  // _saveUserUid(''); // Clear the user UID from shared preferences
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginView()));
}
