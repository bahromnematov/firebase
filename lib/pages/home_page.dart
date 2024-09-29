import 'package:firebase/pages/details_page.dart';
import 'package:firebase/service/auth_service.dart';
import 'package:firebase/service/rtdb_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> items = [];

  _apiPostList() async {
    var list = await RTDBService.getPosts();
    items.clear();
    setState(() {
      items = list;
    });
  }

  void createPostTo() {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return DetailsPage();
    }));
    _apiPostList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AuthService.signOut(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 120,
                  child: items[index].img_url != null
                      ? Image.network(
                          items[index].img_url!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset("assets/img.png")),
              Text(
                items[index].name!,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Text(items[index].content!)
            ],
          );
        },
      ),
      floatingActionButton: kIsWeb
          ? SizedBox()
          : FloatingActionButton(
              onPressed: () {
                createPostTo();
              },
              child: Icon(Icons.add),
            ),
    );
  }
}
