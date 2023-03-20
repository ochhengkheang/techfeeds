import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techfeeds/models/article.dart';
import 'package:techfeeds/view_models/article_view_model.dart';
import 'package:techfeeds/views/home/homescreen.dart';
import 'package:techfeeds/views/search_article/search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  var screenList = <Widget>[HomeScreen(), SearchScreen()];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ArticleViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tech Feeds',
        theme: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Color.fromRGBO(18, 17, 56, 1),
              ),
          textTheme: Theme.of(context).textTheme.apply(fontFamily: ""),
        ),
        home: SafeArea(child: const HomeScreen()),
      ),
    );
  }
}
