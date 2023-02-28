import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfeeds/models/article.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    Key? key,
    required this.article,
    required this.lightGreen,
    required this.fontStyleSemiBold,
    required this.darkBlue,
  }) : super(key: key);

  final Attributes? article;
  final Color lightGreen;
  final TextStyle fontStyleSemiBold;
  final Color darkBlue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
      child: Card(
        elevation: 2,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: article?.thumbnail?.data == null
                ? CircularProgressIndicator()
                : Image.network(
                    fit: BoxFit.fitWidth,
                    width: 333,
                    height: 187,
                    'https://cms.istad.co${article?.thumbnail?.data?.attributes?.url}'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 5, 0),
            child: Row(children: [
              Container(
                  decoration: BoxDecoration(
                      color: lightGreen,
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  padding: EdgeInsets.all(4),
                  child: Text("# ${article?.category?.data?.attributes?.title}",
                      style: fontStyleSemiBold)),
              //space to align left and right
              Spacer(),
              Text("${article?.publishedAt?.substring(0, 10)}",
                  style: fontStyleSemiBold),
              PopupMenuButton(
                icon: Icon(Icons.more_vert_outlined, color: lightGreen),
                elevation: 2,
                color: Colors.white,
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.edit_note),
                          label: Text("Update"))),
                  PopupMenuItem(
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.delete_forever_outlined),
                          label: Text("Delete"))),
                ],
              ),
            ]),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 5, 10),
              child: Text("${article?.title}",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                      fontSize: 22))),
        ]),
      ),
    );
  }
}
