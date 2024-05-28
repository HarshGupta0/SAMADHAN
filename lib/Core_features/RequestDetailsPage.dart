import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Model.dart';
import 'RespondToRequests.dart';
class RequestDetailsPage extends StatelessWidget {
  final Request request;

  RequestDetailsPage({required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Details'),
        backgroundColor: Color(0xFFB3B1D3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request.content,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(height: 8.0),
            Text('User ID: ${request.userId}'),
            SizedBox(height: 4.0),
            Text('Timestamp: ${request.timestamp?.toDate().toLocal().toString() ?? 'No timestamp'}'),
            SizedBox(height: 20.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('requests')
                    .doc(request.id)
                    .collection('responses')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No responses yet.'));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var response = snapshot.data!.docs[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 3,
                        child: ListTile(
                          title: Text(response['response']),
                          subtitle: Text('Responded by: ${response['userId']}'),
                          trailing: Text(response['timestamp'] != null
                              ? (response['timestamp'] as Timestamp).toDate().toLocal().toString()
                              : 'No timestamp'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RespondToRequestPage(request: request),
                ));
              },
              child: Text('Respond to this Request'),
            ),
          ],
        ),
      ),
    );
  }
}
