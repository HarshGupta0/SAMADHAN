import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Requests'),
      ),
      body: RequestsList(),
    );
  }
}

class RequestsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Center(child: Text('You need to be logged in to see your requests.'));
    }

    CollectionReference requests = FirebaseFirestore.instance.collection('requests');

    return StreamBuilder<QuerySnapshot>(
      stream: requests.where('userId', isEqualTo: user.uid).orderBy('timestamp', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No requests found.'));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['content'] ?? 'No Content'),
              subtitle: Text(data['timestamp'] != null
                  ? data['timestamp'].toDate().toString()
                  : 'No Timestamp'),
            );
          }).toList(),
        );
      },
    );
  }
}