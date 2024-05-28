import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_functions.dart';  // Ensure this file has the sign-out function

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String _numberCtrl = "8505063481";
  String userName = "";
  String userEmail = "";
  String userPhoneNumber = "";

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          userName = userDoc['name'];
          userEmail = userDoc['email'];
          userPhoneNumber = userDoc['phoneNumber'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Profile", style: TextStyle(fontWeight: FontWeight.w500)),
          centerTitle: true,
          backgroundColor: Color(0xFFB3B1D3),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xFFB3B1D3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Container(
                          width: 70,
                          height: 70,
                        ),
                      ),
                    ),
                    SizedBox(width:30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        Text(
                          userEmail,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        Text(
                          userPhoneNumber,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CardWidget("Address", Icons.location_on, () {}),
              CardWidget("Privacy and Policy", Icons.privacy_tip_outlined, () {}),
              CardWidget("Help Line", Icons.phone, () async {
                await FlutterPhoneDirectCaller.callNumber(_numberCtrl);
                print("pressed");
              }),
              CardWidget("Contact Us", Icons.mail_outline_sharp, () {
                composeEmail("iharshgupta.07@gmail.com", "Subject", "Body");
              }),
              CardWidget("Logout", Icons.logout, () {
                Signout(context);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget CardWidget(String input, IconData icon, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Color(0xFFB3B1D3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, size: 30),
            SizedBox(width: 40),
            Text(
              input,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> composeEmail(String to, String subject, String body) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: to,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    try {
      if (await canLaunch(emailLaunchUri.toString())) {
        await launch(emailLaunchUri.toString());
      } else {
        throw 'Could not launch email';
      }
    } catch (e) {
      print('Error launching email: $e');
    }
  }
}
