import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfeeds/view_models/article_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var darkBlue = Color.fromRGBO(18, 17, 56, 1);
  var lightGreen = Color.fromRGBO(79, 192, 159, 1);
  var fontStyleCategory = GoogleFonts.poppins(
      fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16);

  var onCategory = 1;
  var page = 1;
  var data = [];
  bool isLoading = false;

  var _scrollController = ScrollController();
  var articleViewModel = ArticleViewModel();

  @override
  void initState() {
    super.initState();
    articleViewModel.getArticles(1, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: Column(
          children: [
            AppBar(
              toolbarHeight: 70.0,
              //elevation: 0.0,
              automaticallyImplyLeading: false,
              flexibleSpace: Container(),
              actions: [
                SizedBox(
                  width: 85,
                  child: TextButton(
                      onPressed: () {},
                      child: Text("POST",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: lightGreen,
                              fontSize: 22))),
                )
              ],
              backgroundColor: Colors.white,
              title: Text("HOME",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                      fontSize: 18)),
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: darkBlue,
                  size: 28,
                ),
                onPressed: () {},
              ),
              leadingWidth: 33,
            ),
            Container(
              height: 55,
              width: double.infinity,
              color: darkBlue,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  textButton(Icons.home, 1, "ALL"),
                  textButton(Icons.web, 2, "Web Developer"),
                  textButton(Icons.code, 3, "Programming"),
                  textButton(Icons.code, 4, "AI / Big Data"),
                  textButton(Icons.analytics_outlined, 5, "Backend"),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          children: [],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: darkBlue,
        currentIndex: 1,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              label: "Home", icon: Icon(Icons.home, color: lightGreen)),
          BottomNavigationBarItem(
              label: "Manage",
              icon: Icon(Icons.app_registration_rounded, color: lightGreen))
        ],
      ),
    );
  }

  TextButton textButton(var icon, var optionNumber, var title) {
    return TextButton.icon(
      icon: Icon(icon,
          color: onCategory == optionNumber ? lightGreen : Colors.white),
      label: Text(title,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: onCategory == optionNumber ? lightGreen : Colors.white,
              fontSize: 16)),
      onPressed: () {
        setState(() {
          onCategory = optionNumber;
        });
      },
    );
  }

  void onScrollToTheMaxBottom() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (page != 3) {
        setState(() {
          isLoading = true;
        });
        page += 1;
        await articleViewModel.getArticles(page, 14);

        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
