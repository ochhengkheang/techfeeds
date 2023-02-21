import 'package:flutter/material.dart';
import 'package:techfeeds/views/home/homescreen.dart';

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
      title: 'Tech Feeds',
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Color.fromRGBO(18, 17, 56, 1),
            ),
        textTheme: Theme.of(context).textTheme.apply(fontFamily: ""),
      ),
      home: SafeArea(child: const HomeScreen()),
    );
  }
}
