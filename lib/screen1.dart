import 'dart:convert';

import 'package:api_practice/post_modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class screen1 extends StatefulWidget {
  const screen1({super.key});

  @override
  State<screen1> createState() => _screen1State();
}

class _screen1State extends State<screen1> {
  //List? ofUser = [];
  List<Posts>? ofUser;
  void getPost() async {
    try {
      var post = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if (post.statusCode == 200) {
        ofUser = Posts.getPostData(jsonDecode(post.body));
        setState(() {});
      } else {
        print(post.statusCode);
      }
    } catch (e) {}
  }

  @override
  void initState() {
    getPost();
    // TODO: implement initState
    super.initState();
  }

  Widget buildCard(Posts post) {
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.grey)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Title",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(post.title ?? ""),
            Divider(),
            Text(
              "Description",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(post.body.toString()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Center(child: Text("TITLE")),
      ),
      body: Column(children: [
        ofUser == null
            ? CircularProgressIndicator()
            : Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: ofUser!.length,
                  itemBuilder: (context, index) {
                    return buildCard(ofUser![index]);
                  },
                ),
              ),
      ]),
    );
  }
}
