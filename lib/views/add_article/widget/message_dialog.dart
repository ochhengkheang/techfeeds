import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var fontStyleSemiBold = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(18, 17, 56, 1),
    fontSize: 12);

Future<dynamic> messaageDialog(BuildContext context, message) {
  return showDialog(
      context: context,
      builder: (_) => new Dialog(
            child: new Container(
              alignment: FractionalOffset.center,
              height: 80.0,
              padding: const EdgeInsets.all(20.0),
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle),
                  new Padding(
                    padding: new EdgeInsets.only(left: 10.0),
                    child: new Text(
                      message,
                      style: fontStyleSemiBold,
                    ),
                  ),
                ],
              ),
            ),
          ));
}
