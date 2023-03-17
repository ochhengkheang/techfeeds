import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfeeds/models/article.dart';
import 'package:techfeeds/views/home/homescreen.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({
    Key? key,
    this.article,
    required this.darkBlue,
    required this.lightGreen,
  }) : super(key: key);

  Attributes? article;
  final Color darkBlue;
  final Color lightGreen;
  var imageUrl;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.imageUrl = widget.article?.thumbnail?.data == null
        ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/681px-Placeholder_view_vector.svg.png'
        : 'https://cms.istad.co${widget.article?.thumbnail?.data?.attributes?.url}';
  }

  var fontStyleBold =
      GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 25);
  var fontStyleContent = GoogleFonts.poppins(
      height: 1.8,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontSize: 13);

  var fontStyleSemiBold = GoogleFonts.poppins(
      fontWeight: FontWeight.w500, color: Colors.black, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: AppBar(
              toolbarHeight: 70.0,
              //backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              flexibleSpace: Container(),
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: widget.lightGreen,
                  )),
              title: Text(
                "Content",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24),
              ),
            )),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 25),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              spacing(15.0),
              //auto size widget height text by text height
              IntrinsicHeight(
                child: Text(
                  widget.article!.title!,
                  style: fontStyleBold,
                ),
              ),
              spacing(15.0),
              Container(
                width: double.infinity,
                height: 3,
                color: widget.darkBlue,
              ),
              spacing(15.0),
              Center(
                child: Image.network(widget.imageUrl,
                    fit: BoxFit.fitWidth, width: 333, height: 187),
              ),
              spacing(15.0),
              Container(
                width: double.infinity,
                height: 3,
                color: widget.darkBlue,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(children: [
                  Container(
                      decoration: BoxDecoration(
                          color: widget.lightGreen,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      padding: EdgeInsets.all(4),
                      child: Text(
                          "# ${widget.article?.category?.data?.attributes?.title}",
                          style: fontStyleSemiBold)),
                  //space to align left and right
                  Spacer(),
                  Text("${widget.article?.publishedAt?.substring(0, 10)}",
                      style: fontStyleSemiBold),
                ]),
              ),
              spacing(10.0),
              IntrinsicHeight(
                  child:
                      Text(widget.article!.content!, style: fontStyleContent)),
            ]),
          ),
        ),
      ),
    );
  }

  SizedBox spacing(var height) {
    return SizedBox(
      height: height,
    );
  }
}
