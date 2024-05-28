import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model.dart';

class RespondToRequestPage extends StatefulWidget {
  final Request request;

  RespondToRequestPage({required this.request});

  @override
  _RespondToRequestPageState createState() => _RespondToRequestPageState();
}

class _RespondToRequestPageState extends State<RespondToRequestPage> {
  final _responseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Respond to Request'),
        backgroundColor: Color(0xFFB3B1D3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.request.content,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _responseController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter your response',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitResponse,
              child: Text('Submit Response'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitResponse() async {
    if (_responseController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Response cannot be empty'),
      ));
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('You must be logged in to respond'),
      ));
      return;
    }

    await FirebaseFirestore.instance
        .collection('requests')
        .doc(widget.request.id)
        .collection('responses')
        .add({
      'response': _responseController.text,
      'userId': user.uid,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _responseController.clear();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Response submitted'),
    ));

    Navigator.of(context).pop();
  }
}
