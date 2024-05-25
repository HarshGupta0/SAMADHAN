import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testgih/Model.dart';

class RequestListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Requests')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('requests').orderBy('timestamp').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Request request = Request.fromFirestore(doc);
              return ListTile(
                title: Text(request.content),
                subtitle: Column(
                  children: [
                    Text('User ID: ${request.userId}'),
                    Text( '${request.id}'),
                  ],
                ),
                //   DateTime.timestamp(),
                // Text('User ID: ${request.userId}'),
                onTap: () {
                  // Respond to request logic
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
