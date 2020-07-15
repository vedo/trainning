import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePick extends StatefulWidget {
  @override
  _ImagePickState createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
       children: [
      _image == null
      ? Text('No image selected.')
            : SizedBox(height: 80, width: 80,  child: Image.file(_image)),

          FloatingActionButton(
           onPressed: getImage,
           tooltip: 'Pick Image',
           child: Icon(Icons.add_a_photo),
         )
       ],
      ),
    );
  }
}