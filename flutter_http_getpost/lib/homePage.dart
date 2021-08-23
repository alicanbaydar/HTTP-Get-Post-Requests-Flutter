import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_http_getpost/commentPage.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final String url = "https://jsonplaceholder.typicode.com/posts/1/comments";

class _MyHomePageState extends State<MyHomePage> {
  late CommentPage postData;
  var commentJson = [];
  httpGet() async {
    try {
      final response = await http.get(Uri.parse(url));
      // print(response.statusCode);
      final jsonData = jsonDecode(response.body) as List;

      // ------ 2 -------
      final veriler = jsonData.map((e) => CommentPage.fromJson(e)).toList();
      postData = veriler.last;
      for (var veri in veriler) {
        print(veri.email);
      }
      //print(jsonData);
      setState(() {
        //  -----1------
        commentJson = jsonData;
      });
    } catch (err) {
      print("error");
    }
  }

  @override
  void initState() {
    super.initState();
    httpGet();
  }

  //son verinin postu
  httpSet(CommentPage postData) async {
    try {
      final response = await http.post(Uri.parse(url),
          body: {"name": postData.name, "email": postData.email});
      //print(response.statusCode);
      var data = response.body;
      print(data);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("HTTP Requests"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: commentJson.length,
          itemBuilder: (context, i) {
            final comment = commentJson[i];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                " ${comment["id"]} - ${comment["email"]} \n ${comment["body"]}",
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            httpSet(postData);
          },
          label: Text("Post Data")),
    );
  }
}
