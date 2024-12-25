import 'package:flutter/material.dart';
import 'package:flutterproject/main.dart';

void main(){
  runApp(MaterialApp(
    home: MyApp(),
  ));
}
class MyApp extends StatelessWidget{
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hello World",
        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent),),
      ),
    );
  }
}
