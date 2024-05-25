import 'package:flutter/material.dart';
import 'package:testgih/requestPage.dart';
import 'package:testgih/userRequest.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateRequestPage()),
                );
              },
              child: Text('Create Request'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserRequestsPage()),
                );
              },
              child: Text('My Requests'),
            ),
          ],
        ),
      ),
    );
  }
}
