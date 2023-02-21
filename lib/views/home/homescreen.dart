import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var darkblue = Color.fromRGBO(18, 17, 56, 1);
  var lightgreen = Color.fromRGBO(79, 192, 159, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: 85,
            child: TextButton(
              onPressed: () {},
              child: Text("POST",
                  style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                      fontWeight: FontWeight.bold,
                      color: lightgreen,
                      fontSize: 18)),
            ),
          )
        ],
        backgroundColor: Colors.white,
        title: Text("HOME",
            style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.bodyLarge,
                fontWeight: FontWeight.bold,
                color: darkblue,
                fontSize: 18)),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: darkblue,
            size: 28,
          ),
          onPressed: () {},
        ),
        leadingWidth: 33,
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: darkblue,
        currentIndex: 1,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              label: "Home", icon: Icon(Icons.home, color: lightgreen)),
          BottomNavigationBarItem(
              label: "Manage",
              icon: Icon(Icons.app_registration_rounded, color: lightgreen))
        ],
      ),
    );
  }
}
