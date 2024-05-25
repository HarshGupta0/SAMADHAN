import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String id;
  String content;
  String userId;
  Timestamp timestamp;

  Request({required this.id, required this.content, required this.userId, required this.timestamp});

  factory Request.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Request(
      id: doc.id,
      content: data['content'] ?? '',
      userId: data['userId'] ?? '',
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'userId': userId,
      'timestamp': timestamp,
    };
  }
}
