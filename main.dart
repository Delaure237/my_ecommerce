import 'package:appecommerce/Navigation.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
         appBarTheme: AppBarTheme(
           elevation: 2.0,
           shadowColor: Colors.black45,
           surfaceTintColor: Colors.white,
           backgroundColor:Colors.white,
           toolbarHeight: 70,
         ),

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home:BottomNavigation(),
    );
  }
}


