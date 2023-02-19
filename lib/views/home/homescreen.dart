import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(18, 17, 56, 1),
        currentIndex: 1,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home, color: Color.fromRGBO(79, 192, 159, 1))),
          BottomNavigationBarItem(
              label: "Manage",
              icon: Icon(Icons.app_registration_rounded,
                  color: Color.fromRGBO(79, 192, 159, 1)))
        ],
      ),
    );
  }
}
