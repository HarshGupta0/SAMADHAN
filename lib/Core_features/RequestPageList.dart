// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'RequestRespondPage.dart';
// import 'Model.dart';
//
// class RequestListPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Requests'),
//         centerTitle: true,
//         backgroundColor: Color(0xFFB3B1D3),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('requests').orderBy('timestamp', descending: true).snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Text(
//                 'No requests found.',
//                 style: TextStyle(fontSize: 18, color: Colors.grey),
//               ),
//             );
//           }
//           return ListView(
//             padding: EdgeInsets.all(16.0),
//             children: snapshot.data!.docs.map((doc) {
//               Request request = Request.fromFirestore(doc);
//               return Card(
//                 margin: EdgeInsets.symmetric(vertical: 8.0),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 elevation: 3,
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//                   title: Text(
//                     request.content,
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 8.0),
//                       Text('User ID: ${request.userId}'),
//                       SizedBox(height: 4.0),
//                       Text(
//                         'Timestamp: ${request.timestamp?.toDate().toLocal().toString() ?? 'No timestamp'}',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                   trailing: Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.teal),
//                   onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => RequestResponsePage(request: request),
//                     ));
//                   },
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }
//comments
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:testgih/Core_features/requestPage.dart';
// import '../Model.dart';
//
// class RequestListPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add,color: Colors.green,),
//         onPressed: (){
//           Navigator.push(context, MaterialPageRoute(builder:(context)=>CreateRequestPage()));
//         },
//       ),
//       appBar: AppBar(
//         title: Text('Requests'),
//         centerTitle: true,
//         backgroundColor: Color(0xFFB3B1D3),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('requests').orderBy('timestamp', descending: true).snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(
//               child: Text(
//                 'No requests found.',
//                 style: TextStyle(fontSize: 18, color: Colors.grey),
//               ),
//             );
//           }
//           return ListView(
//             padding: EdgeInsets.all(16.0),
//             children: snapshot.data!.docs.map((doc) {
//               Request request = Request.fromFirestore(doc);
//               return Card(
//                 margin: EdgeInsets.symmetric(vertical: 8.0),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 elevation: 3,
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//                   title: Text(
//                     request.content,
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 8.0),
//                       Text('User ID: ${request.userId}'),
//                       SizedBox(height: 4.0),
//                       Text(
//                         'Timestamp: ${request.timestamp?.toDate().toLocal().toString() ?? 'No timestamp'}',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                   trailing: Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.teal),
//                   onTap: () {
//                     // Navigator.of(context).push(MaterialPageRoute(
//                     //   builder: (context) => RequestDetailsPage(request: request),
//                     // ));
//                   },
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testgih/Core_features/requestPage.dart';
import '../Model.dart';
import 'RequestDetailsPage.dart';
class RequestListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.green),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateRequestPage()));
        },
      ),
      appBar: AppBar(
        title: Text('Requests'),
        centerTitle: true,
        backgroundColor: Color(0xFFB3B1D3),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('requests').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No requests found.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return ListView(
            padding: EdgeInsets.all(16.0),
            children: snapshot.data!.docs.map((doc) {
              Request request = Request.fromFirestore(doc);
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 3,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  title: Text(
                    request.content,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text('User ID: ${request.userId}'),
                      SizedBox(height: 4.0),
                      Text(
                        'Timestamp: ${request.timestamp?.toDate().toLocal().toString() ?? 'No timestamp'}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.teal),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RequestDetailsPage(request: request),
                    ));
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

