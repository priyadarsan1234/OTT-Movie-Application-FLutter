import 'package:flutter/material.dart';
import 'package:make_my_show/Home.dart';
import 'package:make_my_show/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      home: Login(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Home Page'),
      ),
      body: Center(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: <Widget>[
            const Text(
              'Hello, Flutter!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: const Text('Press Me'),
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => Video()),
            //     // );
            //   },
            //   child: Text('Press Me'),
            // ),  
          ],
        ),
      ),
    );
  }
}
