import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  final String id;
  final String content;
  final String userId;
  final Timestamp? timestamp;

  Request({required this.id, required this.content, required this.userId, this.timestamp});

  factory Request.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Request(
      id: doc.id,
      content: data['content'] ?? '',
      userId: data['userId'] ?? '',
      timestamp: data['timestamp'],
    );
  }

  Stream<List<Map<String, dynamic>>> getResponses() {
    return FirebaseFirestore.instance
        .collection('requests')
        .doc(id)
        .collection('responses')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
