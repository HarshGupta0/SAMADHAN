import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateRequestPage extends StatefulWidget {
  @override
  _CreateRequestPageState createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  final TextEditingController _controller = TextEditingController();

  void _submitRequest() async {
    if (_controller.text.isEmpty) return;
    await FirebaseFirestore.instance.collection('requests').add({
      'content': _controller.text,
      'userId': 'exampleUserId', // Replace with actual user ID
      'timestamp': FieldValue.serverTimestamp(),
    });
    _controller.clear();
    Navigator.of(context).pop();
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
