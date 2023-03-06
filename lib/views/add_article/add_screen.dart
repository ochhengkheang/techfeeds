import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfeeds/models/article.dart';
import 'package:techfeeds/view_models/article_view_model.dart';
import 'package:techfeeds/view_models/image_view_model.dart';

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
  var titleController = TextEditingController();
  var ratingController = TextEditingController();
  var descriptionController = TextEditingController();
  var quantityController = TextEditingController();
  var priceController = TextEditingController();
  @override
  var fontStyleBold = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(18, 17, 56, 1),
      fontSize: 22);

  @override
  void initState() {
    super.initState();
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.article!.title!;
      ratingController.text = widget.article!.!;
      quantityController.text = widget.article!.quantity!;
      descriptionController.text = widget.article!.description!;
      priceController.text = widget.article!.price!;
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: Center(
              child: Text(
            "POST",
            style: fontStyleBold,
          )),
        ),
      ),
    );
  }
}
