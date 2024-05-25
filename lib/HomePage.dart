import 'package:flutter/material.dart';
import 'package:testgih/requestPage.dart';

import 'RequestPageList.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CreateRequestPage()),
                );
              },
              child: Text('Create Request'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RequestListPage()),
                );
              },
              child: Text('View Requests'),
            ),
          ],
        ),
      ),
    );
  }
}
