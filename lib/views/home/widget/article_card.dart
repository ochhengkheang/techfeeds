import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfeeds/models/article.dart';
import 'package:techfeeds/views/add_article/add_screen.dart';

class ArticleCard extends StatelessWidget {
  ArticleCard({
    Key? key,
    required this.id,
    required this.article,
    required this.lightGreen,
    required this.fontStyleSemiBold,
    required this.darkBlue,
  }) : super(key: key);

  var id;
  final Attributes? article;
  final Color lightGreen;
  final TextStyle fontStyleSemiBold;
  final Color darkBlue;
  var imageUrl;
  var haveImage;

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
                onSelected: (value) {
                  switch (value) {
                    case 1:
                      //get image url to show on add screen, thumbnailId get by articleId
                      if (article?.thumbnail?.data == null) {
                        haveImage = false;
                        imageUrl =
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/681px-Placeholder_view_vector.svg.png';
                      } else {
                        haveImage = true;
                        imageUrl =
                            'https://cms.istad.co${article?.thumbnail?.data?.attributes?.url}';
                      }

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddScreen(
                                    article: article,
                                    isUpdate: true,
                                    id: id,
                                    imageUrl: imageUrl,
                                    haveImage: haveImage,
                                  )));
                      break;
                    case 2:
                      print(value);
                      break;
                  }
                },
                icon: Icon(Icons.more_vert_outlined, color: lightGreen),
                elevation: 2,
                color: Colors.white,
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                      value: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit_note),
                          Text('Edit', style: fontStyleSemiBold),
                        ],
                      )),
                  PopupMenuItem(
                      value: 2,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.delete_forever_outlined),
                          Text('Delete', style: fontStyleSemiBold),
                        ],
                      )),
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
