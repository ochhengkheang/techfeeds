import 'dart:io';
import 'dart:math';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:techfeeds/data/response/status.dart';
import 'package:techfeeds/models/article.dart';
import 'package:techfeeds/models/article_request.dart';
import 'package:techfeeds/view_models/article_view_model.dart';
import 'package:techfeeds/view_models/image_view_model.dart';
import 'package:techfeeds/views/add_article/widget/article_textfield.dart';
import 'package:techfeeds/views/home/homescreen.dart';

class AddScreen extends StatefulWidget {
  AddScreen(
      {Key? key,
      this.article,
      this.isUpdate = false,
      this.id,
      this.imageUrl,
      this.haveImage})
      : super(key: key);

  Attributes? article;
  var isUpdate;
  var id;
  var imageUrl;
  var haveImage;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final formKey = GlobalKey<FormState>();

  var articleViewModel = ArticleViewModel();
  var imageViewModel = ImageViewModel();
  var imageFile;
  bool status = true;
  var slug;
  var thumbnailId = null;

  bool isUploaded = false;
  var radioValue;
  var choice;
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  @override
  var fontStyleBold = GoogleFonts.poppins(
      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24);

  var fontStyleSemiBold = GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(18, 17, 56, 1),
      fontSize: 12);

  var lightGreen = Color.fromRGBO(79, 192, 159, 1);
  var darkBlue = Color.fromRGBO(18, 17, 56, 1);

  //not dynamic yet
  var categoryId;
  List<String> categoryName = [
    "1. Web Design",
    "3. Back-End",
    "4. Mobile Development"
  ];

  //not dynamic yet
  var tagId;
  List<String> tagName = ["1. HTML", "2. CSS", "3. JavaScript"];

  @override
  void initState() {
    //customize post UI g
    super.initState();
    setState(() {
      radioValue = "true";
    });
    if (widget.isUpdate) {
      titleController.text = widget.article!.title!;
      slug = widget.article!.slug!;
      contentController.text = widget.article!.content!;
      status = widget.article!.status!;
      //make change  to radius status to update if false or true
      radioValue = "$status";
      if (widget.article!.thumbnail!.data == null)
        widget.haveImage = false;
      else
        thumbnailId = widget.article!.thumbnail!.data!.id!;

      print(widget.id);
      print(slug);
      print(thumbnailId);
      print(widget.imageUrl);
      print(radioValue);
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
      setState(() {
        widget.haveImage = true;
        isUploaded = true;
      });
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
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(18, 17, 56, 1),
                  fontSize: 24),
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: formKey,
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
                      //get Article response status
                      if (articleViewModel.articleResponse.status ==
                          Status.COMPLETED) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Post Article Success')));
                        });
                      }
                      if (imageViewModel.imageResponse.status ==
                          Status.COMPLETED) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Image Upload Success')));
                        });
                      }
                      print(
                          'image url ${imageViewModel.imageResponse.data?.url}');
                      return Center(
                        child: imageFile == null
                            ? widget.isUpdate
                                ? Image.network(widget.imageUrl,
                                    width: 150,
                                    height:
                                        150) //when updated, show image url, if not show notfound image
                                : Image.network(
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
                  spacing(10.0),
                  ArticleFormField(
                      darkBlue: darkBlue,
                      lightGreen: lightGreen,
                      title: "Title",
                      controller: titleController,
                      maxLine: 1),
                  spacing(10.0),
                  ArticleFormField(
                      darkBlue: darkBlue,
                      lightGreen: lightGreen,
                      title: "Content",
                      controller: contentController,
                      maxLine: 10),
                  spacing(10.0),
                  statusRadio(context),
                  spacing(20.0),
                  //make change in the package DropDownField code to make formTextField uneditable
                  DropDownField(
                      labelStyle: fontStyleSemiBold,
                      hintStyle: fontStyleSemiBold,
                      strict: true,
                      textStyle: fontStyleSemiBold,
                      icon: Icon(Icons.category, color: lightGreen),
                      onValueChanged: (dynamic newValue) {
                        categoryId = newValue;
                        print(categoryId);
                      },
                      value: categoryId,
                      required: true,
                      hintText: 'Choose A Category',
                      labelText: 'Category',
                      items: categoryName),
                  spacing(20.0),
                  DropDownField(
                      labelStyle: fontStyleSemiBold,
                      hintStyle: fontStyleSemiBold,
                      strict: true,
                      textStyle: fontStyleSemiBold,
                      icon: Icon(Icons.tag, color: lightGreen),
                      onValueChanged: (dynamic newValue) {
                        tagId = getId(newValue);
                        print(tagId);
                      },
                      value: tagId,
                      required: true,
                      hintText: 'Choose a Tag',
                      labelText: 'Tag',
                      items: tagName),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(lightGreen),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                onPressed: () {
                  print(widget.haveImage);

                  if (widget.haveImage) {
                    if (formKey.currentState!.validate()) {
                      if (isUploaded)
                        thumbnailId = imageViewModel.imageResponse.data!.id;
                      var dataRequest = DataRequest(
                          title: titleController.text,
                          slug: getSlug(titleController.text),
                          status: status,
                          content: contentController.text,
                          thumbnail: thumbnailId.toString(),
                          category: getId(categoryId),
                          tags: getTagList(
                              tagId)); //didn't use dropbox checklist to get many value and add all to list, so convert a string to list string
                      // print(
                      //     "Data Request: Title:${dataRequest.title}, Slug:${dataRequest.slug}, Status:${dataRequest.status}, Content:${dataRequest.content}, ThumbnailId:${dataRequest.thumbnail}, Category:${dataRequest.category}, Tags:${dataRequest.tags}");
                      if (widget.isUpdate) {
                        // check for post or put
                        articleViewModel.putArticle(dataRequest, widget.id);
                        print(dataRequest.thumbnail);
                      } else
                        articleViewModel.postArticle(dataRequest);
                    }
                  } else {
                    _getImageFromGalleryOrCamera('camera');
                  }
                  //do validate post
                },
                child: widget.haveImage
                    ? widget.isUpdate
                        ? Text(
                            "Update",
                            style: fontStyleBold,
                          )
                        : Text(
                            "Submit",
                            style: fontStyleBold,
                          )
                    : Text(
                        "Select Image",
                        style: fontStyleBold,
                      ))),
      ),
    );
  }

  //can't extract to another class since it is statful widget and return value status
  Row statusRadio(BuildContext context) {
    return Row(
      children: [
        Text("STATUS:",
            style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w600)),
        Padding(padding: EdgeInsets.only(left: 5)),
        Spacer(),
        Container(
          decoration: BoxDecoration(
              color: darkBlue, borderRadius: BorderRadius.circular(20)),
          height: 40,
          width: MediaQuery.of(context).size.width - 150,
          child: Theme(
            data:
                Theme.of(context).copyWith(unselectedWidgetColor: Colors.white),
            child: Row(children: [
              Spacer(),
              Radio(
                activeColor: lightGreen,
                value: 'true',
                groupValue: radioValue,
                onChanged: (value) {
                  radioButtonChanges(value);
                },
              ),
              Text("True", style: TextStyle(color: Colors.white)),
              Padding(padding: EdgeInsets.only(left: 50)),
              Radio(
                activeColor: lightGreen,
                value: 'false',
                groupValue: radioValue,
                onChanged: (value) {
                  radioButtonChanges(value);
                },
              ),
              Text("Flase", style: TextStyle(color: Colors.white)),
              Spacer()
            ]),
          ),
        ),
        Spacer(),
      ],
    );
  }

  void radioButtonChanges(var value) {
    setState(() {
      radioValue = value;
      switch (value) {
        case 'true':
          status = true;
          break;
        case 'false':
          status = false;
          break;
        default:
          status = true;
      }
      debugPrint("Status: $status"); //Debug the choice in console
    });
  }

  String getSlug(var titleController) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyyMMddhhmmss');
    final String formatted = formatter.format(now);
    //fix error validation by removing special chars and replacing space with - when posting Slug
    String temp = titleController;
    String replaceSpace = temp.replaceAll(' ', '-');
    final replaceSpecial = replaceSpace.replaceAll(RegExp('[^A-Za-z0-9-]'), '');

    int random = Random().nextInt(1000);
    String converted = "$replaceSpecial-$formatted$random"; //here
    print("Slug: $converted");
    return converted;
  }

  String getId(var categoryName) {
    final endIndex = categoryName.indexOf(".", 0);
    return categoryName.substring(0, endIndex);
  }

  List<String> getTagList(var tagId) {
    List<String> stringList = tagId.split(".");
    print(stringList);
    return stringList;
  }

  SizedBox spacing(var height) {
    return SizedBox(
      height: height,
    );
  }
}
