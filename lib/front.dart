import 'package:flutter/material.dart';

class first extends StatefulWidget {
  const first({super.key});

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Cover the entire screen
        children: [
          // Background Image
          Image.asset(
            'image/pexels-josh-klassen-14699764 1.png', // Replace with your image path
            fit: BoxFit.cover, // Cover the entire screen
          ),
          // Centered Button
          Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                  child:Text("SAMADHAN", style: TextStyle(fontFamily: 'Roboto Sheriff', fontSize: 45),)
              ),
              SizedBox(
                height: 200,
              ),
              ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white
                ),
                child: Text('Get Started', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
              ),
            ],
          )
        ],
      ),
    );
  }
}
