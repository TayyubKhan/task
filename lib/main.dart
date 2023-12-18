import 'package:flutter/material.dart';
import 'package:task/View/CategoryScreen.dart';
import 'package:task/View/AppTabBarView.dart';

import 'View/Category1View1.dart';
bool app=false;
void main() {
  app=true;
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CateogryScreen(),
    );
  }
}
