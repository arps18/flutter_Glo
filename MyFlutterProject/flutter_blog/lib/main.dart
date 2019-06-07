import 'package:flutter/material.dart';
import 'package:flutter_blog/HomePage.dart';
import 'package:flutter_blog/Login.dart';
import 'package:flutter_blog/Mapping.dart';
import 'Authentication.dart';


void main(){
  runApp(new BlogApp());

}

class BlogApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   
   return new MaterialApp
   (
        title: 'Flutter Community',
        theme: new ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: MappingPage(auth: Auth(),),
   );
  }
}