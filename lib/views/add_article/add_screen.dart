import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:techfeeds/data/response/status.dart';
import 'package:techfeeds/models/article.dart';
import 'package:techfeeds/view_models/article_view_model.dart';
import 'package:techfeeds/view_models/image_view_model.dart';
import 'package:techfeeds/views/add_article/widget/article_textfield.dart';
import 'package:techfeeds/views/home/homescreen.dart';

class AddScreen extends StatefulWidget {
  AddScreen({Key? key, this.article, this.isUpdate = false, this.id})
      : super(key: key);

  Attributes? article;
  var isUpdate;
  var id;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  var articleViewModel = ArticleViewModel();
  var imageViewModel = ImageViewModel();
  var imageFile;
  var status;
  var slug;
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  @override
  var fontStyleBold = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(18, 17, 56, 1),
      fontSize: 24);
  var fontStyleSemiBold = GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(18, 17, 56, 1),
      fontSize: 12);
  var lightGreen = Color.fromRGBO(79, 192, 159, 1);
  var darkBlue = Color.fromRGBO(18, 17, 56, 1);

  @override
  void initState() {
    //customize post UI g
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.article!.title!;
      slug = widget.article!.slug!;
      contentController.text = widget.article!.content!;
      status = widget.article!.status!;
    }
  }

  _getImageFromGalleryOrCamera(String type) async {
    print('type $type');
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      setState(() {});
      imageViewModel.uploadImage(pickedFile.path);
      print("Picked File path: ${pickedFile.path}");
    } else
      print('image not picked');
  }

  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            centerTitle: true,
            //primary: false,
            toolbarHeight: 70.0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(),
            elevation: 0,
            title: Text(
              "Create",
              style: fontStyleBold,
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: lightGreen,
                )),
            actions: [
              IconButton(
                  color: lightGreen,
                  onPressed: () {
                    _getImageFromGalleryOrCamera('camera');
                  },
                  icon: const Icon(Icons.camera)),
              IconButton(
                  color: lightGreen,
                  onPressed: () {
                    _getImageFromGalleryOrCamera('gallery');
                  },
                  icon: const Icon(Icons.browse_gallery)),
            ],
          ),
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 3,
                    color: darkBlue,
                  ),
                  ChangeNotifierProvider<ArticleViewModel>(
                    create: (BuildContext ctx) => articleViewModel,
                    child: Consumer(builder: (ctx, image, _) {
                      //get product response status
                      if (articleViewModel.articleResponse.status ==
                          Status.COMPLETED) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Post Article Success')));
                        });
                      }

                      /*double notify listener because they are called in the same notifer in the view model
                      consider create diffrent repo (homeviewmodel and imageview model) and call different notifier
                    */
                      // print('image url ${homeViewModel.imageResponse.data!.url}');
                      return Center(
                        child: imageFile == null
                            ? Image.network(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/681px-Placeholder_view_vector.svg.png',
                                width: 150,
                                height: 150)
                            : Image.file(imageFile,
                                fit: BoxFit.cover, width: 150, height: 150),
                      );
                    }),
                  ),
                  Container(
                    width: double.infinity,
                    height: 3,
                    color: darkBlue,
                  ),
                  spacing(),
                  articleTextField(
                      darkBlue: darkBlue,
                      lightGreen: lightGreen,
                      controller: titleController,
                      title: "Title",
                      maxLine: 1),
                  spacing(),
                  articleTextField(
                      darkBlue: darkBlue,
                      lightGreen: lightGreen,
                      controller: contentController,
                      title: "Content",
                      maxLine: 6),
                  spacing(),
                ],
              ),
            )),
      ),
    );
  }

  SizedBox spacing() {
    return SizedBox(
      height: 10,
    );
  }
}
