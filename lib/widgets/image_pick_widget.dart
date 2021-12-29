import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:e_store_space/statics/static_var.dart';

class MyImagePicker extends StatefulWidget {
  File file;
  String centerText='';
  MyImagePicker({this.file, this.centerText});

  @override
  _MyimagePickerState createState() => _MyimagePickerState();
}

class _MyimagePickerState extends State<MyImagePicker> {

  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
        onTap:pickImageDialog,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            widget.file==null?Container(
              width: double.maxFinite,
              height: 200,
              padding: const EdgeInsets.all(10),
              color: Colors.black12,
              child: const Icon(
                Icons.camera_alt,
                size: 65,
                color: Colors.grey,
              ),
            )
                :Container(
              height: 200,
              width: double.maxFinite,
              child: Image.file(File(widget.file.path),

                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap:(){
                  pickImageDialog();
                  // _openGallery(true);
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white38,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        )

    );
  }

  Future<void> _openGallery(bool openGallary)  {
    ImagePicker().getImage(
        source: openGallary ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 15).then((imageFile) {
      setState(() {
        widget.file = File(imageFile.path);
        List<int> imageBytes = widget.file.readAsBytesSync();
        StaticVariable.baseString = base64Encode(imageBytes);
      });

    });
  }

  pickImageDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text("Complete Action Using"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _openGallery(true);



                  },
                  child: Column(
                    children: const [
                      Icon(
                        Icons.image,
                        color: Colors.orange,
                        size: 30,
                      ),
                      Text("Gallery")
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _openGallery(false);
                  },
                  child: Column(
                    children: const [
                      Icon(
                        Icons.camera_alt,
                        color: Colors.orange,
                        size: 30,
                      ),
                      Text("Camera")
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}