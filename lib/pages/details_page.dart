import 'dart:io';

import 'package:firebase/model/post_model.dart';
import 'package:firebase/pages/home_page.dart';
import 'package:firebase/service/rtdb_service.dart';
import 'package:firebase/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _ismController = TextEditingController();
  final _contentController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
  }

  _createPost() {
    String ism = _ismController.text.trim().toString();
    String content = _contentController.text.trim().toString();
    if (ism.isNotEmpty && content.isNotEmpty) {
      _apiUploadImage(ism, content);
    }
  }

  _apiUploadImage(String ism, String content) {
    StorageService.uploadImage(_image!)
        .then((url) => {_apiCreatePost(ism, content, url)});
  }

  _apiCreatePost(String ism, String content, String url) {
    var post = Post(name: ism, content: content, img_url: url);
    RTDBService.addPost(post).then((value) => {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return HomePage();
          }))
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            'Rasm tanlang',
            style: TextStyle(
                color: Colors.orange,
                fontSize: 26,
                fontWeight: FontWeight.w700),
          ),
          InkWell(
            onTap: () {
              _getImage();
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.orange),
                  borderRadius: BorderRadius.circular(25)),
              height: 100,
              width: 100,
              child: _image != null
                  ? Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "assets/img.png",
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 56,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2, color: Colors.grey)),
            child: TextField(
              controller: _ismController,
              decoration:
                  InputDecoration(hintText: "Ism", border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 56,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2, color: Colors.grey)),
            child: TextField(
              controller: _contentController,
              decoration: InputDecoration(
                  hintText: "Content", border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: _createPost,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.blue),
              child: Center(
                child: Text(
                  "Add Post",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
