import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:techfeeds/data/response/status.dart';
import 'package:techfeeds/models/article.dart';
import 'package:techfeeds/view_models/article_view_model.dart';
import 'package:techfeeds/views/add_article/add_screen.dart';
import 'package:techfeeds/views/home/homescreen.dart';

class ArticleCard extends StatelessWidget {
  ArticleCard({
    Key? key,
    required this.id,
    required this.article,
    required this.lightGreen,
    required this.fontStyleSemiBold,
    required this.fontStyleBold,
    required this.darkBlue,
  }) : super(key: key);

  var id;
  final Attributes? article;
  final Color lightGreen;
  final TextStyle fontStyleSemiBold;
  final TextStyle fontStyleBold;
  final Color darkBlue;
  var imageUrl;
  var haveImage;
  var fontStyleMessage = GoogleFonts.poppins(
      fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16);
  var fontStyleButton = GoogleFonts.poppins(
      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20);
  var styleButton = ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(Color.fromRGBO(79, 192, 159, 1)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));

  @override
  Widget build(BuildContext context) {
    var articleViewModel = ArticleViewModel();
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
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0))),
                              backgroundColor: darkBlue,
                              title: Center(
                                  child: Text('Are your sure?',
                                      style: fontStyleBold)),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                        "Are you sure that you want to delete this? The items will be  deleted and permanently removed from your feed.",
                                        textAlign: TextAlign.justify,
                                        style: fontStyleMessage),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 125,
                                          child: TextButton(
                                              style: styleButton,
                                              child: Text('Cancel',
                                                  style: fontStyleButton),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              }),
                                        ),
                                        SizedBox(
                                          width: 125,
                                          child: TextButton(
                                              style: styleButton,
                                              child: Text('Delete',
                                                  style: fontStyleButton),
                                              onPressed: () {
                                                articleViewModel
                                                    .deleteArticle(id);
                                                SchedulerBinding.instance
                                                    .addPostFrameCallback(
                                                        (timeStamp) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              HomeScreen()));
                                                });

                                                //Navigator.of(context).pop();
                                              }),
                                        )
                                      ])
                                ],
                              ),
                            );
                          });
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
