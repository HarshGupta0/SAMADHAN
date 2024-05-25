import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateRequestPage extends StatefulWidget {
  @override
  _CreateRequestPageState createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  final TextEditingController _controller = TextEditingController();

  void _submitRequest() async {
    if (_controller.text.isEmpty) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('requests').add({
        'content': _controller.text,
        'userId': user.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _controller.clear();
      Navigator.of(context).pop();
    } else {
      // Handle the case when the user is not signed in
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You must be logged in to create a request.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Request')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Request'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitRequest,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
